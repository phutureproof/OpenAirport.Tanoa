params ["_newUnit", "_oldUnit", "_respawn", "_respawnDelay"];

// handle actions on old and new player objects
removeAllActions _oldUnit;
[_newUnit] call OA_fnc_playerActions;

// cleanup any tasks that were attached to the player
_taskID = player getVariable ["taskID", false];
if (_taskID) then {
    [_taskID] call BIS_fnc_deleteTask;
    player setVariable ["taskID", false];
};
