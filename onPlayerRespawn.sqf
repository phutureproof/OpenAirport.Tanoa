params ["_newUnit", "_oldUnit", "_respawn", "_respawnDelay"];

removeAllActions _oldUnit;
_taskID = player getVariable ["taskID", false];
if (_taskID) then {
    [_taskID] call BIS_fnc_deleteTask;
    player setVariable ["taskID", false];
};
[_newUnit] call OA_fnc_playerActions;
