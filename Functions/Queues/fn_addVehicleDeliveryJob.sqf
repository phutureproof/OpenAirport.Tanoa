if (!isServer) exitWith {};

params ["_vehicle"];

_q = missionNamespace getVariable ["OA_airport_delivery_jobs", []];
_q pushBack [_vehicle];
missionNamespace setvariable ["OA_airport_delivery_jobs", _q, true];
