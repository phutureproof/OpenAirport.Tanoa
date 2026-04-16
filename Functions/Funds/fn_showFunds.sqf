_funds = missionNamespace getVariable ["OA_airport_funds", 0];
_formattedFunds = [_funds] call OA_fnc_formatIntAsCurrency;

hint format ["Airport funds: %1", _formattedFunds];