params ["_msg", ["_sender", MissionLogic]];
_gameLogicChannel = missionNamespace getVariable["OA_ATCMissionLogicChannelID", 0];
[_sender, [_gameLogicChannel, _msg]] remoteExec ["customChat", 0, true];
[format ["OA LOG :: %1", _msg]] remoteExec["diag_log", 2];
