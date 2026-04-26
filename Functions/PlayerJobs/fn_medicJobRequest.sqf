params ["_player"];

if (!isServer) exitWith {};

// sanity checks
// player already has a task
if (_player getVariable ["OA_hasTask", false]) exitWith {
    ["You already have a job request"] remoteExec ["hint", _clientID];
};

_player setVariable ["OA_hasTask", true];

// add task to get into a vehicle
_taskGetIn = [_player, 'Board Vehicle', "You have a medical job waiting. Get into a helicopter. You may need help to complete this mission and you will need medical equipment which can be purchased from the shop.", [], 'getin' ] call OA_fnc_genericTask;
_numVehSeats = 0;

// wait until player is in vehicle
waitUntil {
    sleep 1;
    ([_player] call OA_fnc_jobPlayerInVehicle && (vehicle _player isKindOf "Helicopter"))
};

_vehicle = vehicle _player;
_numVehSeats = _vehicle emptyPositions "Cargo";

// remove the task to board vehicle 
[_taskGetIn, "SUCCEEDED"] call BIS_fnc_taskSetState;
[_taskGetIn] call BIS_fnc_deleteTask;

_spawnPoint = [(getMarkerPos "civSpawn"), 1000, 2000 + floor(random(20000)), 0.5, 0, 0.1, 0] call BIS_fnc_findSafePos;
_doSmoke = true;
_jobDistance = getMarkerPos "civSpawn" distance _spawnPoint;

// add a marker to the map and assign it within its own radius of the destination
_markerPos = [_spawnPoint, 100, 400, 0.5, 0, 0.1, 0] call BIS_fnc_findSafePos;
_markerName = format ["rescue-marker-%1", floor(random(999999))];
_marker = createMarker [_markerName, _markerPos];
_marker setMarkerPos _markerPos;
_marker setMarkerBrush "GRID";
_marker setMarkerShape "ELLIPSE";
_marker setMarkerSize [500, 500];
_marker setMarkerColor "ColorYellow";

_taskRescue = [_player, 'Locate Injured People', "Somewhere within the search area are injured people, they have been attacked by local wildlife and need rescuing! Find them, treat them, and take them back to the airport. You will have to check the map for the search area.", [], 'getin' ] call OA_fnc_genericTask;

_group = createGroup civilian;
_player setVariable ["OA_taskGroup", _group];

// spawn civs
for "_i" from 1 to _numVehSeats do {
    [_group, _spawnPoint, 25] call OA_fnc_spawnPassenger;
};

// civs having a bad time
{
    _x setDamage (selectRandom [0.3, 0.4, 0.5, 0.6, 0.7, 0.8]);
    _x disableAI "PATH";
    [_x, true] remoteExec ["setUnconscious", 0, true];
    [_x, "Unconscious"] remoteExec ["switchMove", 0, true];

    // hold action on injured civ
    [
        _x,
        "Revive Injured",
        "\a3\ui_f\data\IGUI\Cfg\HoldActions\holdAction_revive_ca.paa",
        "\a3\ui_f\data\IGUI\Cfg\HoldActions\holdAction_revive_ca.paa",
        "_this distance _target < 3 && 'FirstAidKit' in (items _this)",
        "_this distance _target < 3",
        {},
        {},
        {
            params ["_target", "_caller", "_actionID", "_args"];
            _caller removeItem "FirstAidKit";
            _vehicle = _args select 0;
            _target setDamage 0;
            [_target, false] remoteExec ["setUnconscious", 0, true];
            [_target, ""] remoteExec ["switchMove", 0, true];
            [_target, (_this select 2)] remoteExec ["BIS_fnc_holdActionRemove", 0, true];
            _target enableAI "PATH";
            _target assignAsCargo _vehicle;
            [_target] orderGetIn true;
        },
        {},
        [_vehicle],
        10,
        1000,
        true,
        false
    ] remoteExec ["BIS_fnc_holdActionAdd", 0, true];
} forEach (units _group);

_smoke = objNull;
_smokeTimer = time - 60;
waitUntil {
    if (time - _smokeTimer > 60) then {
        if (!isNull _smoke) then { deleteVehicle _smoke; };
        _smokePos = [_spawnPoint, 1, 5, 0.5, 0, 0.1, 0] call BIS_fnc_findSafePos;
        _smoke = createVehicle [selectRandom [
            "SmokeShell",
            "SmokeShellRed",
            "SmokeShellGreen",
            "SmokeShellBlue",
            "SmokeShellYellow",
            "SmokeShellOrange",
            "SmokeShellPurple"
        ], _smokePos, [], 0, "CAN_COLLIDE"];
        _smokeTimer = time;
    };
    sleep 1;
    _units = ({ alive _x } count (units _group));
    _inVehicle = ({_x in _vehicle} count (units _group));
    (_units == _inVehicle)
};

[_taskRescue, "SUCCEEDED"] call BIS_fnc_taskSetState;
[_taskRescue] call BIS_fnc_deleteTask;

// remove the marker
deleteMarker _markerName;

_dest = getMarkerPos "OA_pickupzone_marker";

_taskUnLoad = [_player, 'Drop passengers off at the airport', 'Take the passengers back to the airport', _dest, 'getout'] call OA_fnc_genericTask;

waitUntil {
    sleep 1;
    ([_player, _vehicle] call OA_fnc_jobPlayerInPickupArea)
};

[_taskUnLoad, "SUCCEEDED"] call BIS_fnc_taskSetState;
[_taskUnLoad] call BIS_fnc_deleteTask;

// wait until we're at the destination 
waitUntil {
    sleep 1;
    ([_vehicle, _dest] call OA_fnc_jobAtPassengerDest)
};

// passengers disembark
{ unassignVehicle _x; [_x] orderGetIn false; } forEach (units _group);

waitUntil {
    sleep 1;
    _remaining = { _x in _vehicle } count (units _group);
    _remaining == 0
};

// have the passengers move away so it looks a little nicer
_pos = getMarkerPos "civSpawn";
_group move _pos;

// remove task variables from the player
_player setVariable ["OA_hasTask", false];
_player setVariable ["OA_taskGroup", nil];



// create a payment
_tip = floor(random(1.5 * _jobDistance));
_payment = ((_jobDistance * 2.5) * _numVehSeats) + _tip;
[_payment] call OA_fnc_updateFunds;
_distanceFormatted = [_jobDistance] call OA_fnc_formatIntAsKilometers;

_atcMessage = format [
    "%1 has finished a job! Earning %2 for %3 passengers at a distance of around %4, and a tip of %5",
    name _player,
    [_payment] call OA_fnc_formatIntAsCurrency,
    _numVehSeats,
    _distanceFormatted,
    [_tip] call OA_fnc_formatIntAsCurrency
];

[_atcMessage] call OA_fnc_sendATCMsg;

// cleanup 
sleep 60;
{
    deleteVehicle _x;
} forEach (units _group);

deleteGroup _group;

if (!(isNull _smoke)) then {
    deleteVehicle _smoke;
};
