if (!isServer) exitWith {};

["Saving game state"] call OA_fnc_sendGlobalMsg;

// game state
_funds = missionNamespace getVariable ["OA_airport_funds", 0];
profileNamespace setVariable ["OA_airport_funds", _funds];

[] call OA_fnc_savePlayerData;

// write profile to server
saveProfileNamespace;

["Game has been saved"] call OA_fnc_sendGlobalMsg;
