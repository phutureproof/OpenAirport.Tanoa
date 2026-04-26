if (!isServer) exitWith {};

// Air Traffic Control
private _channelName = "ATC";
private _channelID = radioChannelCreate [[0.96, 0.34, 0.13, 1], _channelName, "%UNIT_NAME", []];
if (_channelID == 0) exitWith {format ["Custom channel '%1' creation failed!", _channelName] remoteExec ["hint"]};
missionNamespace setVariable ["OA_ATCRadioChannelID", _channelID, true];
_channelID radioChannelAdd [ATC];

// Mission Logic
private _channelName2 = "Mission Logic";
private _channelID2 = radioChannelCreate [[0.13, 0.34, 0.96, 1], _channelName2, "%UNIT_NAME", []];
if (_channelID2 == 0) exitWith {diag_log format ["Custom channel '%1' creation failed!", _channelName2]};
[_channelID2, {_this radioChannelAdd [player]}] remoteExec ["call", [0, -2] select isDedicated, _channelName2];
missionNamespace setVariable ["OA_ATCMissionLogicChannelID", _channelID2, true];
_channelID2 radioChannelAdd [MissionLogic];
