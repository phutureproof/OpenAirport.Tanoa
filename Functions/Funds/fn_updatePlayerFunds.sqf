params ["_player", "_amount"];

if (!isServer) exitWith {};

_funds = _player getVariable ["OA_player_money", 0];
_new = _funds + _amount;
_player setVariable ["OA_player_money", _new, true];
_new
