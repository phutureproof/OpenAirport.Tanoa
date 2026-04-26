params ["_msg", ["_sender", ATC]];
_atcChannel = missionNamespace getVariable["OA_ATCradioChannelID", 0];
[_sender, [_atcChannel, _msg]] remoteExec ["customChat", 0, true];
[format ["OA LOG :: %1", _msg]] remoteExec["diag_log", 2];
