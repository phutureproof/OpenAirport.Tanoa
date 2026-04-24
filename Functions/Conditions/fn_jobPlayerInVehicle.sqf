params ["_player"];

_inVehicle = !(isNull objectParent _player);
_vehType = ((vehicle _player) isKindOf "Air");

_inVehicle && _vehType