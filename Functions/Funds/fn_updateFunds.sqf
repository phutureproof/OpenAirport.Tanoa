params ["_amount"];

if (isServer) then {
	_current = missionNamespace getVariable ["OA_airport_funds", 0];
	_new = _current + _amount;
	missionNamespace setVariable ["OA_airport_funds", _new, true];
	_new
};