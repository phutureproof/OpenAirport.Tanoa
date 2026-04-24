if (isServer) then {

	_vehicles = profileNamespace getVariable ["OA_airport_vehicles", []];

	{ deleteVehicle _x; } forEach _vehicles;

	profileNamespace setVariable ["OA_airport_vehicles", nil];
	profileNamespace setVariable ["OA_airport_funds", nil];
	sleep 1;
	saveProfileNamespace;
	
	["Game has been reset, you should restart the mission"] call OA_fnc_sendATCMsg;
};
