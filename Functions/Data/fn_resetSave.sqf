if (!isServer) exitWith {};

["Game state is being reset"] call OA_fnc_sendGlobalMsg;

_vehicles = profileNamespace getVariable ["OA_airport_vehicles", []];
_startingFunds = missionNamespace getVariable ["OA_starting_funds", 0];

{ 
	_isAirportVehicle = _x getVariable ["OA_airport_vehicle", false];
	if (_isAirportVehicle) then {
		deleteVehicle _x;
	};
} forEach vehicles;

profileNamespace setVariable ["OA_airport_vehicles", nil];
profileNamespace setVariable ["OA_airport_funds", nil];
missionNamespace setVariable ["OA_airport_funds", _startingFunds, true];
missionNamespace setVariable ["OA_player_starting_balance", 0, true];
profileNamespace setVariable ["OA_player_starting_balance", 0];
saveProfileNamespace;

[] call OA_fnc_loadData;
[] call OA_fnc_saveData;

["Wiping player data"] call OA_fnc_sendGlobalMsg;

profileNamespace setVariable ["OA_player_data", nil];
saveProfileNamespace;

["Game has been reset and reloaded"] call OA_fnc_sendGlobalMsg;
