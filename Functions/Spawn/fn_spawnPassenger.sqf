params ["_group", "_spawnPoint", ["_radius", 2]];

private _civilianClasses = missionNamespace getVariable ["OA_civilianList", []];
private _unitType = selectRandom _civilianClasses;
private _unit = _group createUnit [_unitType, _spawnPoint, [], _radius, "NONE"];

_unit allowFleeing 0;
_unit setBehaviour "CARELESS";
_unit setSpeedMode "FULL";

_unit