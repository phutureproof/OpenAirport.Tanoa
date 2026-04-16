params ["_player"];

if (isServer) then {
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
    _numCivs = (ceil(_seats / 2)) + floor(random (_seats / 2));
    _group = createGroup civilian;

    // spawn civilian group
    for "_i" from 1 to _numCivs do {
        [_group, _vehicle] call OA_fnc_spawnPassenger;
    };

    // order them to get in
    units _group orderGetIn true;

    // create a task to wait for passengers
    _taskLoad = format ["job_%1_%2", name _player, round(random(9999999))];
    [_player, _taskLoad, ["Wait for all passengers to board.", "Load Passengers", ""], _vehicle, "ASSIGNED", 2, true, "getin", true] call BIS_fnc_taskCreate;

    // wait until all passengers are in the vehicle
    waitUntil {
        sleep 1;
        _units = { alive _x } count(units _group);
        _inVehicle = { _x in _vehicle } count (units _group);
        _units == _inVehicle
    };
    [_taskLoad, "SUCCEEDED"] call BIS_fnc_taskSetState;

    // create task for player HUD
    _taskID = format ["job_%1_%2", name _player, round(random(9999999))];
    [_player, _taskID, ["Transport the passengers to their destination.", "Transport Passengers"], _dest, "ASSIGNED", 2, true, "move", true] call BIS_fnc_taskCreate;
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
        moveOut _x;
    } forEach (units _group);

    waitUntil {
        sleep 1;
        _remaining = { _x in _vehicle } count (units _group);
        _remaining == 0
    };

    // have the passengers move away so it looks a little nicer
    //_pos = [_vehicle, 100, 200, 3, 0, 20, 0] call BIS_fnc_findSafePos;
    //_group move _pos;

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

    // cleanup 
    sleep 60;
    {
        deleteVehicle _x;
    } forEach (units _group);

    deleteGroup _group;
};