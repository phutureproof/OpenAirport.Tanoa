params ["_msg"];

_atcChannel = missionNamespace getVariable["OA_ATCradioChannelID", 0];
ATC customChat [_atcChannel, _msg];
