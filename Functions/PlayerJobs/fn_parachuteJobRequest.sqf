params ["_player"];

if (isServer) then {

    // sanity checks
    // player already has a task
    if (_player getVariable ["OA_hasTask", false]) exitWith {
        ["You already have a job request"] remoteExec ["hint", _clientID];
    };

    _player setVariable ["OA_hasTask", true];

    // add task to get into a vehicle
    _taskGetIn = [_player, 'Board Vehicle', "You have a job waiting! Get into a helicopter or plane.", [], 'getin' ] call OA_fnc_genericTask;
    _numVehSeats = 0;

    // wait until player is in vehicle
    waitUntil {
        sleep 1;
        _inVehicle = !(isNull objectParent _player);
		_vehType = ((vehicle _player) isKindOf "Air");
        _inVehicle && _vehType
    };
    _numVehSeats = count (fullCrew [vehicle _player, "", true]) - 1;

    // remove the task to board vehicle 
    [_taskGetIn, "SUCCEEDED"] call BIS_fnc_taskSetState;
    [_taskGetIn] call BIS_fnc_deleteTask;

    _vehicle = vehicle _player;
    _spawnPoint = getMarkerPos "civSpawn";
	_dest = [];
    _doSmoke = false;
	if (_vehicle isKindOf "Helicopter") then { _dest = [] call OA_fnc_getRandomHelicopterDestination; _doSmoke = true; };
	if (_vehicle isKindOf "Plane") then { _dest = [] call OA_fnc_getRandomPlaneDestination; _doSmoke = false; };

    _jobDistance = _spawnPoint distance _dest;

    _numCivs = (1 + floor(random(_numVehSeats)));
    if (_numCivs < ceil(_numVehSeats / 2)) then { _numCivs = ceil(_numVehSeats / 2); }; // at least half
    if (_numCivs > _numVehSeats) then { _numCivs = _numVehSeats; }; // no more than max
    _group = createGroup civilian;
    _player setVariable ["OA_taskGroup", _group];

    // spawn civilian group
    for "_i" from 1 to _numCivs do {
        [_group, _spawnPoint] call OA_fnc_spawnPassenger;
        sleep 0.1;
    };

    // create a task to wait for passengers
    _taskLoad = [_player, 'Load Passengers', 'Move to the pickup zone and wait for all passengers to board', getMarkerPos "OA_pickupzone_marker", 'getin'] call OA_fnc_genericTask;

    waitUntil {
        sleep 1;
        _inArea = ((_vehicle inArea OA_passengerPickupArea) && (_player in _vehicle));
        _stopped = ((speed _vehicle) < 1);
        _grounded = ((getPosATL _vehicle select 2) < 1);
        _inArea && _stopped && _grounded
    };

    // order passengers to get in
    _group addVehicle _vehicle;
    (units _group) orderGetIn true;

    // wait until all passengers are in the vehicle
    _time = time;
    waitUntil {
        sleep 1;
        _units = { alive _x } count(units _group);
        _inVehicle = { _x in _vehicle } count (units _group);
        /*
        if (time - _time > 45) then {
            { _x moveInAny _vehicle; } forEach (units _group);
        };
        */
        _units == _inVehicle
    };
    [_taskLoad, "SUCCEEDED"] call BIS_fnc_taskSetState;
    [_taskLoad] call BIS_fnc_deleteTask;

    // create task for player HUD
    _taskID = [_player, 'Transport Passengers', 'Transport the passengers to their destination', _dest, 'move'] call OA_fnc_genericTask;
    // save task to play incase of death 
    _player setVariable ["OA_taskID", _taskID];

    // when player gets near destination let off a smoke grenade 
    waitUntil {
        sleep 1;
        _atDest = _vehicle distance _dest < 1000;
        _atDest
    };

    _smoke = objNull;
    if (_doSmoke) then {
        _smoke = createVehicle [selectRandom [
            "SmokeShell",
            "SmokeShellRed",
            "SmokeShellGreen",
            "SmokeShellBlue",
            "SmokeShellYellow",
            "SmokeShellOrange",
            "SmokeShellPurple"
        ], _dest, [], 0, "CAN_COLLIDE"];
    };

    // wait until we're at the destination 
    waitUntil {
        sleep 1;
        _atDest = _vehicle distance2D _dest < 250;
        _atHeight = ((getPosATL _vehicle) select 2 >= 250);
        _atDest && _atHeight
    };

    // passengers eject
    _group leaveVehicle _vehicle;
    {
        _x action ["EJECT", _vehicle];
        sleep 1;
    } forEach (units _group);

    waitUntil {
        sleep 1;
        _remaining = { _x in _vehicle } count (units _group);
        _remaining == 0
    };

    // have the passengers move away so it looks a little nicer
    _pos = [_vehicle, 200, 500, 0] call BIS_fnc_findSafePos;
    _group move _pos;
    

    // complete the task
    [_taskID, "SUCCEEDED"] call BIS_fnc_taskSetState;
    [_taskID] call BIS_fnc_deleteTask;
    _player setVariable ["OA_taskID", false];


    // remove the hasTask flag
    _player setVariable ["OA_hasTask", false];

    // create a payment
    _tip = random(floor(0.5 * _jobDistance));
    _payment = _jobDistance * _numCivs + _tip;
    [_payment] call OA_fnc_updateFunds;
    _distanceFormatted = [_jobDistance] call OA_fnc_formatIntAsKilometers;

    _atcMessage = format [
        "%1 has finished a job! Earning %2 for %3 passengers at a distance of around %4, and a tip of %5",
        name _player,
        [_payment] call OA_fnc_formatIntAsCurrency,
        _numCivs,
        _distanceFormatted,
        [_tip] call OA_fnc_formatIntAsCurrency
    ];

    [_atcMessage] call OA_fnc_sendATCMsg;

    // set a task to return close to the airport 
    _taskReturn = [_player, 'Return to the airport', 'Return to the airport', getMarkerPOS 'civSpawn', 'move'] call OA_fnc_genericTask;

    waitUntil {
        sleep 1;
        _dist = (_player distance getMarkerPOS 'civSpawn') <= 1000;
        _dist
    };

    [_taskReturn, "SUCCEEDED"] call BIS_fnc_taskSetState;
    [_taskReturn] call BIS_fnc_deleteTask;

    // cleanup 
    sleep 5;
    {
        deleteVehicle _x;
    } forEach (units _group);

    deleteGroup _group;

    if (!(isNull _smoke)) then {
        deleteVehicle _smoke;
    };
};
