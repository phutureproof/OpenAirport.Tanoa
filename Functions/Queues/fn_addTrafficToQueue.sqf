params ["_group"];

_q = missionNamespace getVariable ["OA_airport_traffic_queue", []];
_q pushBack _group;
missionNamespace setvariable ["OA_airport_traffic_queue", _q];
