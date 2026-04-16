params ["_job", "_player", "_target"];

if (isServer) then {
	_queue = missionNamespace getVariable ["OA_airport_refuel_jobs", []];
	_queue pushBack [_job, _player, _target];

	missionNamespace setVariable["OA_airport_refuel_jobs", _queue, true];

	_position = count _queue;
	_atcMsg = format ["Refuel request recieved %1, you are at position %2 in the queue", name _player, _position];
	[_atcMsg] call OA_fnc_sendATCMsg;
};
