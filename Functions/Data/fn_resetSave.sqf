if (isServer) then {

	_vehicles = profileNamespace getVariable ["OA_airport_vehicles", []];
	_startingFunds = missionNamespace getVariable ["OA_starting_funds", 0];

	{ deleteVehicle _x; } forEach _vehicles;

	profileNamespace setVariable ["OA_airport_vehicles", nil];
	profileNamespace setVariable ["OA_airport_funds", nil];
	missionNamespace setVariable ["OA_airport_funds", _startingFunds, true];
	sleep 1;
	saveProfileNamespace;
	
	["Game has been reset, you should restart the mission"] call OA_fnc_sendATCMsg;
};
