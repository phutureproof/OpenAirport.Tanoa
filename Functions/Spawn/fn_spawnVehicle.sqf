if (!isServer) exitWith {};

params ["_vehicle", ["_damage", 0.25], ["_fuel", 0.25]];

_vehicles = profileNamespace getVariable ["OA_airport_vehicles", []];

_veh = createVehicle [_vehicle, getMarkerPos "vehicleSpawn", [], 0, "NONE"];
_veh setVehiclePosition [getMarkerPos "vehicleSpawn", [], 0, "NONE"];
_veh setDir markerDir "vehicleSpawn"; 
_veh setCaptive true;
_veh setFuel _fuel;
_veh setDamage _damage;
_veh setVariable ["OA_airport_vehicle", true, true];

_vehicles pushBack [
	typeOf _veh,
	getPosASL _veh,
	getDir _veh,
	fuel _veh,
	damage _veh,
	getObjectTextures _veh
];

profileNamespace setVariable ["OA_airport_vehicles", _vehicles];
saveProfileNamespace;

_veh