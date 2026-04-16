params ["_player", "_target"];

if (isServer) then {

	_repairCost = missionNamespace getVariable ["OA_repair_cost", 0];
	_formattedRepairCost = [_repairCost] call OA_fnc_formatIntAsCurrency;

	_crew = repairCrew;
	// keep vehicle at full health and fully fueled
	[vehicle leader _crew, 1] remoteExec ["setFuel"];
	[vehicle leader _crew, 0] remoteExec ['setDamage'];

	_pos = [_target, 0, 1, 0] call BIS_fnc_findSafePos;
	_crew move _pos;

	_time = time;
	waitUntil {
		sleep 1;
		_dist = (leader _crew distance _pos <= 20);
		if (time - _time > 120) exitWith {true};
		_dist
	};

	[_target, 0] remoteExec ["setDamage"];
	
	sleep 5;

	[-(_repairCost)] call OA_fnc_updateFunds;
	[format ["%1 spent %2 repairing a vehicle", name _player, _formattedRepairCost]] call OA_fnc_sendATCMsg;

	_pos = [getMarkerPos "repairPoint", 1, 2] call BIS_fnc_findSafePos;
	_crew move _pos;

	true
};
