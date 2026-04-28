if (!isServer) exitWith {};

params ["_startingBalance"];

_time = time;
_timeout = false;
waitUntil { 
	sleep 1;
	if (time - _time > 60) then { _timeout = true; };
	!isNil "OA_reset_from_params" 
};
if (!_timeout && OA_reset_from_params) then {
	{ _x setVariable ["OA_player_money", _startingBalance, true]; } forEach allPlayers;
	missionNamespace setVariable ["OA_player_starting_balance", _startingBalance, true];
	profileNamespace setVariable ["OA_player_starting_balance", _startingBalance];
	saveProfileNamespace;
};
OA_player_starting_balance_from_params = true;