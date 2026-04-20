params ["_msg"];

_atcChannel = missionNamespace getVariable["OA_ATCradioChannelID", 0];
[ATC, [_atcChannel, _msg]] remoteExec ["customChat", 0, true];
[format ["OA LOG :: %1", _msg]] remoteExec["diag_log", 2];
