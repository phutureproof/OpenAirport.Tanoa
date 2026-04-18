params ["_msg"];

_atcChannel = missionNamespace getVariable["OA_ATCradioChannelID", 0];
[ATC, [_atcChannel, _msg]] remoteExec ["customChat"];
