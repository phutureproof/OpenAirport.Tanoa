params ["_vehicle", "_dest"];

_atDest = (_vehicle distance _dest < 100);
_stopped = (speed _vehicle < 1);
_grounded = ((getPosATL _vehicle select 2) < 1);

(_atDest && _stopped && _grounded)