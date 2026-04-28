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
        ([_player] call OA_fnc_jobPlayerInVehicle)
    };
    
    _vehicle = vehicle _player;
    _numVehSeats = _vehicle emptyPositions "Cargo";

    // remove the task to board vehicle 
    [_taskGetIn, "SUCCEEDED"] call BIS_fnc_taskSetState;
    [_taskGetIn] call BIS_fnc_deleteTask;

    _spawnPoint = getMarkerPos "civSpawn";
	_dest = [] call OA_fnc_getHelicopterDestination;
    _doSmoke = true;
    _jobDistance = _spawnPoint distance _dest;

    _group = createGroup civilian;
    _player setVariable ["OA_taskGroup", _group];

    // spawn civilian group
    for "_i" from 1 to _numVehSeats do {
        [_group, _spawnPoint] call OA_fnc_spawnPassenger;
        sleep 0.1;
    };

    // give them parachutes
    {
        [_x] remoteExec ["removeBackpack", 2];
        [_x, "B_Parachute"] remoteExec ["addBackpack", 2];
    } forEach (units _group);

    // create a task to wait for passengers
    _taskLoad = [_player, 'Move To Pickup Area', 'Move to the pickup area and wait the passengers.', getMarkerPos "OA_pickupzone_marker", 'getin'] call OA_fnc_genericTask;

    waitUntil {
        sleep 1;
        ([_player, _vehicle] call OA_fnc_jobPlayerInPickupArea)
    };

    [_taskLoad, "SUCCEEDED"] call BIS_fnc_taskSetState;
    [_taskLoad] call BIS_fnc_deleteTask;

    _taskPassengers = [_player, 'Wait For Passengers', 'Wait for the passengers to board your vehicle.', (leader _group), 'getin'] call OA_fnc_genericTask;

    // order passengers to get in
    { _x assignAsCargo _vehicle; [_x] orderGetIn true; } forEach (units _group);

    // wait until all passengers are in the vehicle
    _time = time;
    waitUntil {
        sleep 1;
        ([_group, _vehicle] call OA_fnc_jobUnitsInVehicle)
    };

    [_taskPassengers, "SUCCEEDED"] call BIS_fnc_taskSetState;
    [_taskPassengers] call BIS_fnc_deleteTask;

    // create task for player HUD
    _taskID = [_player, 'Transport Passengers', 'Transport the passengers to their destination, you must be above 250m for the passengers to jump out.', _dest, 'move'] call OA_fnc_genericTask;
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
        ([_vehicle, _dest] call OA_fnc_jobAtParachuteDest)
    };

    // passengers eject
    {
        unassignVehicle _x;
        [_x] orderGetIn false;
        _x action ["EJECT", _vehicle];
        if ( random(5) >= 2.5 ) then {
            _smokeTrail = createVehicle [selectRandom [
                "SmokeShell",
                "SmokeShellRed",
                "SmokeShellGreen",
                "SmokeShellBlue",
                "SmokeShellYellow",
                "SmokeShellOrange",
                "SmokeShellPurple"
            ], getPos _x, [], 0, "NONE"];
            _smokeTrail attachTo [_x, [0, 0, 0.1], "spine3"];
        };
        sleep 0.1;
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
    _payment = (_jobDistance * _numVehSeats);
    _tip = floor((_payment * 0.1) + random(_payment * 0.5));
    [_payment] call OA_fnc_updateFunds;
    [_player, _tip] call OA_updatePlayerFunds;
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
