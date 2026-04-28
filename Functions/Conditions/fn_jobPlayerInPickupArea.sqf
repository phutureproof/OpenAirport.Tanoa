params ["_player", "_vehicle"];

_inArea = ((_vehicle inArea OA_passengerPickupArea) && (_player in _vehicle));
_stopped = ((speed _vehicle) < 1);
_grounded = ((getPosATL _vehicle select 2) < 1);

(_inArea && _stopped && _grounded)