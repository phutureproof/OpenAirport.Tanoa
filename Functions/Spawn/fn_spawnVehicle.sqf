params ["_vehicle"];

if (isServer) then {
	_veh = createVehicle [_vehicle, getMarkerPos "vehicleSpawn", [], 0, "NONE"];
	_veh setFuel 0.75;
	_veh setDamage 0.1; 
};