params ["_player", "_type"];

if (isServer) then {
	// vars
    private _spawnPos = getMarkerPos "cargoSpawn";
    private _cargo = objNull;
	private _vehicle = objNull;
	private _lightCargo = ["C_Quadbike_01_F", "CargoNet_01_barrels_F", "CargoNet_01_box_F", "I_CargoNet_01_ammo_F", "O_CargoNet_01_ammo_F", "C_IDAP_CargoNet_01_supplies_F", "I_E_CargoNet_01_ammo_F"];
	private _dest = [] call OA_fnc_getRandomDestination;
	private _jobDistance = _spawnPos distance getPos _dest;
	private _multiplier = 1;

	// switch based on weight of cargo
    switch (_type) do {
        case "light": {
            _cargo = (selectRandom _lightCargo) createVehicle _spawnPos;
			[_cargo, 500] remoteExec ["setMass"]; // make sure whatever we just spawned is carryable by all helicopters
			_multiplier = 5;
        };
		case "medium": {
            _cargo = (selectRandom _lightCargo) createVehicle _spawnPos;
			[_cargo, 500] remoteExec ["setMass"]; // make sure whatever we just spawned is carryable by all helicopters
			_multiplier = 15;
        };
		case "heavy": {
            _cargo = (selectRandom _lightCargo) createVehicle _spawnPos;
			[_cargo, 500] remoteExec ["setMass"]; // make sure whatever we just spawned is carryable by all helicopters
			_multiplier = 30;
        };
    };

	// task get in vehicle
    _taskGetIn = [_player, 'Board Vehicle', "You have a job waiting! Get into a vehicle that can carry light cargo", _player, 'getin'] call OA_fnc_genericTask;
    waitUntil {
        sleep 1;
        !(isNull objectParent _player)
    };
    [_taskGetIn] call BIS_fnc_deleteTask;
	_vehicle = vehicle _player;

	// task pickup cargo
	_taskPickupCargo = [_player, 'Attach the Cargo', 'Attach the cargo to your vehicle ready for transportation', _cargo, 'container'] call OA_fnc_genericTask;
	waitUntil {
		sleep 1;
		(getSlingLoad _vehicle == _cargo)
	};
	[_taskPickupCargo] call BIS_fnc_deleteTask;

	// task deliver the cargo
	_taskDeliver = [_player, 'Deliver the cargo', 'Deliver the cargo to the destination', _dest, 'container'] call OA_fnc_genericTask;
	waitUntil {
		sleep 1;
		_dist = (_cargo distance _dest) < 100;
		_detached = isNull (getSlingLoad _vehicle);

		_dist && _detached
	};
	[_taskDeliver] call BIS_fnc_deleteTask;

	// calculate payment
	_payment = _jobDistance * _multiplier;
    [_payment] call OA_fnc_updateFunds;

	// ATC message
    _atcMessage = format [
        "%1 has finished a job! Earning %2 for cargo delivered with a %3x multiplier at a distance of %4m",
        name _player,
        [_payment] call OA_fnc_formatIntAsCurrency,
		_multiplier,
        _jobDistance
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
	sleep 60;
	deleteVehicle _cargo;

};
