if (!isServer) exitWith {};

["Saving game state"] call OA_fnc_sendGlobalMsg;

// game state
_funds = missionNamespace getVariable ["OA_airport_funds", 0];
profileNamespace setVariable ["OA_airport_funds", _funds];

// date and weather 
_date = date;
_time = daytime;
_date set [3, floor(_time)];
_date set [4, (_time - floor(_time)) * 60];
profileNamespace setVariable ["OA_time_of_day", _date];

_weatherOvercast = overcast * 100;
profileNamespace setVariable ["OA_weather_overcast", _weatherOvercast];

_playerStartingBalance = missionNamespace getVariable ["OA_player_starting_balance", 0];
if (_playerStartingBalance > 0) then {
	profileNamespace setVariable ["OA_player_starting_balance", _playerStartingBalance];
};

// vehicles
_vehicles = [];
{
	if (_x getVariable ["OA_airport_vehicle", false]) then {
		_vehicles pushBack [
			typeOf _x,
			getPosASL _x,
			getDir _x,
			fuel _x,
			damage _x,
			getObjectTextures _x
		];
	};
} forEach vehicles;
profileNamespace setVariable ["OA_airport_vehicles", _vehicles];

[] call OA_fnc_savePlayerData;

// write profile to server
saveProfileNamespace;

["Game has been saved"] call OA_fnc_sendGlobalMsg;
