params ["_callingPlayerName", "_vehicleClassName", "_vehicleFriendlyName", "_vehiclePrice"];

private _formattedVehiclePrice = [_vehiclePrice] call OA_fnc_formatIntAsCurrency;

if (missionNamespace getVariable ["OA_airport_funds", 0] < _vehiclePrice) exitWith {
	hint "Not enough money to buy vehicle";
};

[_vehicleClassName, _vehiclePrice] remoteExec ["OA_fnc_addVehicleDeliveryJob", 2];
[(_vehiclePrice * -1)] remoteExec ["OA_fnc_updateFunds", 2];

[format [
	"%1 has purchased a %2 for %3, keep an eye on the sky, delivery is inbound, you should make sure the vehicle delivery zone is clear",
	_callingPlayerName,
	_vehicleFriendlyName,
	_formattedVehiclePrice
]] call OA_fnc_sendATCMsg;
