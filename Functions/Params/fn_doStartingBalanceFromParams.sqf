if (!isServer) exitWith {};

params ["_startingBalance"];

_time = time;
_timeout = false;
waitUntil {
	sleep 1;
	if (time - _time > 60) then {_timeout = true;};
	!isNil "OA_reset_from_params"
};

if (!_timeout && OA_reset_from_params) then {
	[_startingBalance] call OA_fnc_updateFunds;
};

OA_starting_balance_from_params = true;
