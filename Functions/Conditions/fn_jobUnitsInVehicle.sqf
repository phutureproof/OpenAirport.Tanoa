params ["_group", "_vehicle"];

_units = { alive _x } count(units _group);
_inVehicle = { _x in _vehicle } count (units _group);

(_units == _inVehicle)