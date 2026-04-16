if (isServer) then {
	// funds
	_funds = missionNamespace getVariable ["OA_airport_funds", 0];
	profileNamespace setVariable ["OA_airport_funds", _funds];

	// vehicles
	_vehicles = [];
	{
		if (_x isKindOf "Air" || _x isKindOf "Car" || _x isKindOf "Tank") then {
			_vehicles pushBack[
				typeOf _x,
				getPosASL _x,
				getDir _x,
				fuel _x,
				damage _x
			];
		};
	} forEach vehicles;
	profileNamespace setVariable ["OA_airport_vehicles", _vehicles];

	saveProfileNamespace;

	[ATC, "Game has been saved"] remoteExec ["globalChat"];
};
