if (isServer) then
{
	private _channelName = "ATC";
	private _channelID = radioChannelCreate [[0.96, 0.34, 0.13, 0.8], _channelName, "%UNIT_NAME", []];
	if (_channelID == 0) exitWith {format ["Custom channel '%1' creation failed!", _channelName] remoteExec ["hint"]};
	missionNamespace setVariable ["OA_ATCRadioChannelID", _channelID, true];
	[_channelID, {_this radioChannelAdd [player]}] remoteExec ["call", [0, -2] select isDedicated, _channelName];
	_channelID radioChannelAdd [ATC];
	["Welcome to OpenAirport"] call OA_fnc_sendATCmsg;
};
