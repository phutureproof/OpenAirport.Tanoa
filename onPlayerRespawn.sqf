params ["_newUnit", "_oldUnit", "_respawn", "_respawnDelay"];

// handle actions on old and new player objects
removeAllActions _oldUnit;
[_newUnit] call OA_fnc_playerActions;

_gameLogicChannel = missionNamespace getVariable ["OA_ATCMissionLogicChannelID", 0];
_gameLogicChannel radioChannelAdd [player];
setCurrentChannel _gameLogicChannel;

// cleanup any tasks that were attached to the player
_taskID = player getVariable ["OA_taskID", ""];
if (_taskID != "") then {
    [_taskID] call BIS_fnc_deleteTask;
};

// cleanup any groups the player had 
_group = player getVariable ["OA_taskGroup", grpNull];
if (!isNull _group) then {
    [{
        {
            deleteVehicle _x;
        } forEach units _group;
        deleteGroup _group;
    }] remoteExec ["call", 2];
};

// set any player variables back to default
player setVariable ["OA_taskID", ""];
player setVariable ["OA_hasTask", false];
player setVariable ["OA_taskGroup", grpNull];
player setUnitTrait ["Medic", true];

// remove parachute from player
[player] remoteExec ["removeBackpack", 2];

// force the loading screen to close 
_EndSplashScreen = {
    for "_x" from 1 to 10 do {
        endLoadingScreen;
        sleep 5;
    };
};

[] spawn _EndSplashScreen;