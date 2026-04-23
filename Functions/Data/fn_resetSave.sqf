if (isServer) then {

	_vehicles = profileNamespace getVariable ["OA_airport_vehicles", []];

	{ deleteVehicle _x; } forEach _vehicles;

	profileNamespace setVariable ["OA_airport_funds", 500000];
	missionNamespace setVariable ["OA_airport_funds", 500000, true];
	profileNamespace setVariable ["OA_airport_vehicles", []];
	saveProfileNamespace;
	
	["Game has been reset, you should restart the mission"] call OA_fnc_sendATCMsg;
};
