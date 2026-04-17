params ["_player", "_minPassengers", "_maxPassengers"];

if (isServer) then {

    // add task to get into a vehicle
    _taskGetIn = [_player, 'Board Vehicle', format["You have a job waiting! Get into a vehicle that can carry up to %1 passengers.", _maxPassengers], _player, 'getin' ] call OA_fnc_genericTask;

    // wait until player is in vehicle and has enough seats
    waitUntil {
        sleep 1;
        _inVehicle = !(isNull objectParent _player);
        _numSeats = (vehicle _player emptyPositions "Cargo" >= _maxPassengers);
        _inVehicle && _numSeats
    };

    // remove the task to board vehicle 
    [_taskGetIn, "SUCCEEDED"] call BIS_fnc_taskSetState;
    [_taskGetIn] call BIS_fnc_deleteTask;

    _clientID = owner _player;
    _vehicle = vehicle _player;
    _spawnPoint = getMarkerPos "civSpawn";
    _dest = [] call OA_fnc_getRandomDestination;

    _jobDistance = _spawnPoint distance getPos _dest;

    // sanity checks
    // player already has a task
    if (_player getVariable ["hasTask", false]) exitWith {
        ["You already have a job request"] remoteExec ["hint", _clientID];
    };

    _player setVariable ["hasTask", true];

    _seats = _vehicle emptyPositions "Cargo";
    _numCivs = (1 + floor(random(_maxPassengers)));
    if (_numCivs < ceil(_seats / 2)) then { _numCivs = ceil(_seats / 2); }; // at least half
    if (_numCivs > _seats) then { _numCivs = _seats; }; // no more than max
    _group = createGroup civilian;

    // spawn civilian group
    for "_i" from 1 to _numCivs do {
        [_group, _vehicle, _spawnPoint] call OA_fnc_spawnPassenger;
    };

    // order them to get in
    units _group orderGetIn true;

    // create a task to wait for passengers
    _taskLoad = [_player, 'Load Passengers', 'Wait for all passengers to board', _vehicle, 'getin'] call OA_fnc_genericTask;

    // wait until all passengers are in the vehicle
    waitUntil {
        sleep 1;
        _units = { alive _x } count(units _group);
        _inVehicle = { _x in _vehicle } count (units _group);
        _units == _inVehicle
    };
    [_taskLoad, "SUCCEEDED"] call BIS_fnc_taskSetState;
    [_taskLoad] call BIS_fnc_deleteTask;

    // create task for player HUD
    _taskID = [_player, 'Transport Passengers', 'Transport the passengers to their destination', _dest, 'move'] call OA_fnc_genericTask;
    // save task to play incase of death 
    _player setVariable ["taskID", _taskID];

    // wait until we're at the destination 
    waitUntil {
        sleep 1;
        _atDest = _vehicle distance _dest < 100;
        _stopped = speed _vehicle < 1;
        _grounded = isTouchingGround _vehicle;

        _atDest && _stopped && _grounded
    };

    // passengers disembark
    {
        unassignVehicle _x;
        [_x] orderGetIn false;
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
    _player setVariable ["taskID", false];


    // remove the hasTask flag
    _player setVariable ["hasTask", false];

    // create a payment
    _tip = random(floor(0.5 * _jobDistance));
    _payment = _jobDistance * _numCivs + _tip;
    [_payment] call OA_fnc_updateFunds;
    _distanceFormatted = _jobDistance / 1000;

    _atcMessage = format [
        "%1 has finished a job! Earning %2 for %3 passengers at a distance of %4km, and a tip of %5",
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
};