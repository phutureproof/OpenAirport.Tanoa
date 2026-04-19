params ["_player"];

if (isServer) then {
	private _quad = objNull;
	private _pos = _player modelToWorld [0, 1, 0];
	_quad = "C_Quadbike_01_F" createVehicle _pos;
	_quad setFuel 1;
	_quad setDamage 0;
	_quad addEventHandler ["GetOut", {
		params ["_vehicle", "_role", "_unit", "_turret", "_isEject"];
		if (_role == 'driver') then {
			deleteVehicle _vehicle;
		};
	}];
};