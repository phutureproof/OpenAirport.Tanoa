params ["_newUnit", "_oldUnit", "_respawn", "_respawnDelay"];

// handle actions on old and new player objects
removeAllActions _oldUnit;
[_newUnit] call OA_fnc_playerActions;

_newUnit linkItem "ItemRadio";
_atcChannel = missionNamespace getVariable ["OA_ATCRadioChannelID", 0];
_atcChannel radioChannelAdd [player];
[_atcChannel] remoteExec ["setCurrentChannel", owner _newUnit];

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
