params ["_player"];

private _menuPriority = 15;

private _refuelCost = missionNamespace getVariable ["OA_refuel_cost", 0];
private _formattedRefuelCost = [_refuelCost] call OA_fnc_formatIntAsCurrency;

private _repairCost = missionNamespace getVariable ["OA_repair_cost", 0];
private _formattedRepairCost = [_repairCost] call OA_fnc_formatIntAsCurrency;

_player addAction ["<t color='#00FF00'>Check Wallet</t>", {
	params ["_target", "_caller"];
	_funds = _caller getVariable ["OA_player_money", 0];
	_formattedFunds = [_funds] call OA_fnc_formatIntAsCurrency;
	hint format ["Personal funds: %1", _formattedFunds];
}, [], _menuPriority, false, true, "", 'true'];

_player addAction ["<t color='#00FF00'>Request Airport Balance</t>", {
	params ["_target", "_caller"];
	_funds = missionNamespace getVariable ["OA_airport_funds", 0];
	_formattedFunds = [_funds] call OA_fnc_formatIntAsCurrency;
	_atcMsg = format ["Requesting airport balance, over."];
	[_atcMsg, _caller] call OA_fnc_sendATCMsg;
	sleep (1 + round(random(3)));
	_atcMsg = format ["Roger that %1, current balance is %2", name _caller, _formattedFunds];
	[_atcMsg] call OA_fnc_sendATCMsg;
}, [], _menuPriority, false, true, "", '("ItemRadio" in (items _this + assignedItems _this))'];

_player addAction ["<t color='#00FF00'>Transport Quad</t>", {
	params ["_target", "_caller"];
	[_caller] remoteExec ["OA_fnc_spawnTransportQuad", 2];
}, [], _menuPriority, false, true, "", '(isNull objectParent _this) && (_this getVariable ["OA_transport_quad", false])'];

_player addAction [ format ["<t color='#00FF00'>Request Refuel (%1)</t>", _formattedRefuelCost], {
	params ["_target", "_caller"];
	_atcMsg = format ["This is %1 requesting a refuel at vehicle %2, over.", name _caller, getText (configFile >> "CfgVehicles" >> typeOf (vehicle _caller) >> "displayName")];
	[_atcMsg, _caller] call OA_fnc_sendATCMsg;
	sleep (1 + round(random(3)));
	["refuel", _caller, vehicle _caller] remoteExec ["OA_fnc_addRefuelJobToQueue", 2];
}, [], _menuPriority, false, true, "", "!(isNull objectParent _this) && ('ItemRadio' in (items _this + assignedItems _this)) && (vehicle _this isKindOf 'Air') && (_this distance (getMarkerPos 'civSpawn') < 500)"];

_player addAction [ format ["<t color='#00FF00'>Request Repair (%1)</t>", _formattedRepairCost], {
	params ["_target", "_caller"];
	_atcMsg = format ["This is %1 requesting a repair at vehicle %2, over.", name _caller, getText (configFile >> "CfgVehicles" >> typeOf (vehicle _caller) >> "displayName")];
	[_atcMsg, _caller] call OA_fnc_sendATCMsg;
	sleep (1 + round(random(3)));
	["repair", _caller, vehicle _caller] remoteExec ["OA_fnc_addRepairJobToQueue", 2];
}, [], _menuPriority, false, true, "", "!(isNull objectParent _this) && ('ItemRadio' in (items _this + assignedItems _this)) && (vehicle _this isKindOf 'Air') && (_this distance (getMarkerPos 'civSpawn') < 500)"];
