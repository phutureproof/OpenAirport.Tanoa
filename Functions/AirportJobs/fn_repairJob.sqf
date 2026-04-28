params ["_player", "_target"];

if (!isServer) exitWith {};

private _repairCost = missionNamespace getVariable ["OA_repair_cost", 0];
private _formattedRepairCost = [_repairCost] call OA_fnc_formatIntAsCurrency;

private _funds = missionNamespace getVariable ["OA_airport_funds", 0];
if (_funds < _repairCost) exitWith {"Not enough money to repair" remoteExec ["hint", owner _player]};

private _crew = repairCrew;
// keep vehicle at full health and fully fueled
[vehicle leader _crew, 1] remoteExec ["setFuel"];
[vehicle leader _crew, 0] remoteExec ['setDamage'];

private _pos = _target modelToWorld [-1, -1, 0];
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

[_target, 0] remoteExec ["setDamage"];

[-(_repairCost)] call OA_fnc_updateFunds;
[format ["%1 spent %2 repairing a vehicle", name _player, _formattedRepairCost]] call OA_fnc_sendATCMsg;

_pos = getMarkerPos "repairPoint";
(leader _crew) doMove _pos;

true
