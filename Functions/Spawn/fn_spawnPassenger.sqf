params ["_group", "_spawnPoint"];

private _civilianClasses = missionNamespace getVariable ["OA_civilianList", []];
private _unitType = selectRandom _civilianClasses;
private _unit = _group createUnit [_unitType, _spawnPoint, [], 0, "NONE"];
_unit setBehaviour "CARELESS";
_unit setSpeedMode "FULL";

_unit