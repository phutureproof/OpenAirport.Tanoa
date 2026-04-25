params ["_player"];

if (!isServer) exitWith {};

[_player] spawn {
	params ["_player"];

	private _quad = objNull;
	private _pos = _player modelToWorld [1, 1, 0.5];
	private _quadTimeout = 10;

	_quad = "C_Quadbike_01_F" createVehicle _pos;
	_quad setVariable ["driven", false];
	_quad setDir (getDir _player);
	_quad setCaptive true;
	_quad setFuel 1;
	_quad setDamage 0;

	_quad addEventHandler ["GetIn", {
		params ["_vehicle", "_role", "_unit", "_turret", "_isEject"];
		if (_role == 'driver') then {
			_vehicle setVariable ["driven", true];
		};
	}];
	_quad addEventHandler ["GetOut", {
		params ["_vehicle", "_role", "_unit", "_turret", "_isEject"];
		if (_role == 'driver') then {
			deleteVehicle _vehicle;
		};
	}];

	_time = time;
	waitUntil {
		(time - _time > _quadTimeout)
	};

	if ( !(_quad getVariable ["driven", false]) ) then {
		deleteVehicle _quad;
	};
};
