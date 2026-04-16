params ["_player", "_target"];

if (isServer) then {

	_refuelCost = missionNamespace getVariable ["OA_refuel_cost", 0];
	_formattedRefuelCost = [_refuelCost] call OA_fnc_formatIntAsCurrency;

	_crew = refuelCrew;
	// keep vehicle at full health and fully fueled
	[vehicle leader _crew, 1] remoteExec ["setFuel"];
	[vehicle leader _crew, 0] remoteExec ["setDamage"];

	_pos = [_target, 0, 1, 0] call BIS_fnc_findSafePos;
	_crew move _pos;

	_time = time;
	waitUntil {
		sleep 1;
		_dist = (leader _crew distance _pos <= 20);
		_refueled = (fuel _target == 1);
		if (time - _time > 120) exitWith {true};
		_dist && _refueled
	};

	[_target, 1] remoteExec ["setFuel"];

	[-(_refuelCost)] call OA_fnc_updateFunds;
	[format ["%1 spent %2 refueling a vehicle", name _player, _formattedRefuelCost]] call OA_fnc_sendATCMsg;

	_pos = [getMarkerPos "refuelPoint", 1, 2] call BIS_fnc_findSafePos;
	_crew move _pos;

	true
};