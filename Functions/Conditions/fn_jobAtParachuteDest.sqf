params ["_vehicle", "_dest"];

_atDest = _vehicle distance2D _dest <= 500;
_atHeight = ((getPosATL _vehicle) select 2 >= 250);

_atDest && _atHeight