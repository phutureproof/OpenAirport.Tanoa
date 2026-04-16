params ["_group", "_vehicle"];

_unitType = selectRandom ["C_man_1", "C_man_polo_1_F", "C_man_shorts_1_F"];
_unit = _group createUnit [_unitType, _spawnPoint, [], 0, "NONE"];
_unit setBehaviour "CARELESS";
_unit setSpeedMode "FULL";
_unit assignAsCargo _vehicle;

_unit