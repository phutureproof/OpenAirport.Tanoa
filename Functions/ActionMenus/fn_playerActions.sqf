params ["_player"];

private _menuPriority = 15;

private _refuelCost = missionNamespace getVariable ["OA_refuel_cost", 0];
private _formattedRefuelCost = [_refuelCost] call OA_fnc_formatIntAsCurrency;

private _repairCost = missionNamespace getVariable ["OA_repair_cost", 0];
private _formattedRepairCost = [_repairCost] call OA_fnc_formatIntAsCurrency;

_player addAction ["<t color='#00FF00'>Request Airport Balance</t>", {
	params ["_target", "_caller"];
	_funds = missionNamespace getVariable ["OA_airport_funds", 0];
	_formattedFunds = [_funds] call OA_fnc_formatIntAsCurrency;
	_atcMsg = format ["Requesting airport balance, over."];
	[_atcMsg, _caller] call OA_fnc_sendATCMsg;
	sleep (1 + round(2));
	_atcMsg = format ["Roger that %1, current balance is %2", name _caller, _formattedFunds];
	[_atcMsg] call OA_fnc_sendATCMsg;
}, [], _menuPriority, false, true, "", '("ItemRadio" in (items _this + assignedItems _this))'];

_player addAction ["<t color='#00FF00'>Transport Quad</t>", {
	params ["_target", "_caller"];
	[_caller] remoteExec ["OA_fnc_spawnTransportQuad", 2];
}, [], _menuPriority, false, true, "", '(isNull objectParent _this) && ("Keys" in (items _this + assignedItems _this))'];

_player addAction [ format ["<t color='#00FF00'>Request Refuel (%1)</t>", _formattedRefuelCost], {
	params ["_target", "_caller"];
	["refuel", _caller, vehicle _caller] remoteExec ["OA_fnc_addRefuelJobToQueue", 2];
}, [], _menuPriority, false, true, "", "!(isNull objectParent _this) && (vehicle _this isKindOf 'Air') && (_this distance (getMarkerPos 'civSpawn') < 1000)"];

_player addAction [ format ["<t color='#00FF00'>Request Repair (%1)</t>", _formattedRepairCost], {
	params ["_target", "_caller"];
	["repair", _caller, vehicle _caller] remoteExec ["OA_fnc_addRepairJobToQueue", 2];
}, [], _menuPriority, false, true, "", "!(isNull objectParent _this) && (vehicle _this isKindOf 'Air') && (_this distance (getMarkerPos 'civSpawn') < 1000)"];

_player addAction ["================", {}, [], _menuPriority, false, true, "", "!(isNull objectParent _this) && (vehicle _this isKindOf 'Air') "];