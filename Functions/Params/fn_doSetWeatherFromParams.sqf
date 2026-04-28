if (!isServer) exitWith {};

params ["_weather"];

if (_weather == 200) then {
	_weatherOvercast = profileNamespace getVariable ["OA_weather_overcast", 0];
	[_weatherOvercast] call BIS_fnc_paramWeather;
} else {
	_time = time;
	_timeout = false;
	waitUntil { 
		sleep 1;
		if (time - _time > 10) then { _timeout = true; };
		!isNil "OA_server_init_done" 
	};
	if (!_timeout) then {
		_weather call BIS_fnc_paramWeather;
	};
};
