if (!isServer) exitWith {};
["Saving game state"] call OA_fnc_sendGlobalMsg;
// funds
_funds = missionNamespace getVariable ["OA_airport_funds", 0];
profileNamespace setVariable ["OA_airport_funds", _funds];
saveProfileNamespace;
["Game has been saved"] call OA_fnc_sendGlobalMsg;
