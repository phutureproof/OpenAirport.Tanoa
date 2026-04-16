if (isServer) then {

	profileNamespace setVariable ["OA_airport_funds", 100000];
	missionNamespace setVariable ["OA_airport_funds", 100000];
	profileNamespace setVariable ["OA_airport_vehicles", []];
	saveProfileNamespace;

	{
		if (_x isKindOf "Air" || _x isKindOf "Car" || _x isKindOf "Tank") then {
			deleteVehicle _x;
		};
	} forEach vehicles;
	

	["Game has been reset, you should restart the mission"] call OA_fnc_sendATCMsg;
};
