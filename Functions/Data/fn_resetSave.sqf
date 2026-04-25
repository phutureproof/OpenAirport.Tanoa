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

sleep 1;
[] call OA_fnc_loadData;
sleep 1;
[] call OA_fnc_saveData;
sleep 1;
["Game has been reset and reloaded"] call OA_fnc_sendGlobalMsg;
