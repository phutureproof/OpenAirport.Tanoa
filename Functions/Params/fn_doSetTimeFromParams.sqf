if (!isServer) exitWith {};

params ["_timeParam"];

if (_timeParam == 24) then {
	_timeOfDay = profileNamespace getVariable ["OA_time_of_day", [2026, 4, 27, 8, 0]];
	setDate _timeOfDay;
} else {
	_time = time;
	_timeout = false;
	waitUntil { 
		sleep 1;
		if (time - _time > 10) then { _timeout = true; };
		!isNil "OA_server_init_done" 
	};
	if (!_timeout) then {
		[_timeParam] call BIS_fnc_paramDayTime;
	};
};

