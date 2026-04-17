params ["_player", "_target"];

if (isServer) then {

	private _refuelCost = missionNamespace getVariable ["OA_refuel_cost", 0];
	private _formattedRefuelCost = [_refuelCost] call OA_fnc_formatIntAsCurrency;

	private _crew = refuelCrew;
	// keep vehicle at full health and fully fueled
	[vehicle leader _crew, 1] remoteExec ["setFuel"];
	[vehicle leader _crew, 0] remoteExec ["setDamage"];

	private _pos = _target modelToWorld [1, 1, 0];
	(leader _crew) doMove _pos;

	waitUntil {
		sleep 1;
		_dist = (leader _crew distance _pos <= 50);
		_dist 
	};

	private _time = time;
	waitUntil {
		sleep 1;
		_timer = (time - _time >= 15);
		_timer
	};

	[_target, 1] remoteExec ["setFuel"];

	[-(_refuelCost)] call OA_fnc_updateFunds;
	[format ["%1 spent %2 refueling a vehicle", name _player, _formattedRefuelCost]] call OA_fnc_sendATCMsg;

	_pos = getMarkerPos "refuelPoint";
	(leader _crew) doMove _pos;

	true
};