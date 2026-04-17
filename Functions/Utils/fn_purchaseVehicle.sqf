params ["_callingPlayerName", "_vehicleClassName", "_vehicleFriendlyName", "_vehiclePrice"];

if (missionNamespace getVariable ["OA_airport_funds", 0] < _vehiclePrice) exitWith {
	hint "Not enough money to buy vehicle";
};

[_vehicleClassName] remoteExec ["OA_fnc_spawnVehicle", 2];

[_vehiclePrice * -1] remoteExec ["OA_fnc_updateFunds", 2];

[format ["%1 has purchased a %2 for %3", name _callingPlayerName, _vehicleFriendlyName, [_vehiclePrice] call OA_fnc_formatIntAsCurrency]] call OA_fnc_sendATCMsg;