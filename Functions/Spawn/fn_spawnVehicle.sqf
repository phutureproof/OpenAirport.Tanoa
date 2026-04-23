params ["_vehicle"];

if (isServer) then {
	_vehicles = profileNamespace getVariable ["OA_airport_vehicles", []];
	_veh = createVehicle [_vehicle, getMarkerPos "vehicleSpawn", [], 0, "NONE"];
	_vehicles pushBack [
		typeOf _veh,
		getPosASL _veh,
		getDir _veh,
		fuel _veh,
		damage _veh
	];
	profileNamespace setVariable ["OA_airport_vehicles", _vehicles];
	saveProfileNamespace;
	_veh setFuel 0.75;
	_veh setDamage 0.1; 
};
