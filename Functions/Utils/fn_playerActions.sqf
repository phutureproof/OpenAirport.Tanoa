params ["_player"];

_refuelCost = missionNamespace getVariable ["OA_refuel_cost", 0];
_formattedRefuelCost = [_refuelCost] call OA_fnc_formatIntAsCurrency;

_repairCost = missionNamespace getVariable ["OA_repair_cost", 0];
_formattedRepairCost = [_repairCost] call OA_fnc_formatIntAsCurrency;

_player addAction ["<t color='#00FF00'>Show Airport Balance</t>", {
	params ["_target", "_caller"];
	[] call OA_fnc_showFunds;
}, [], 9, false, true];

_player addAction ["<t color='#00FF00'>Request Job</t>", {
	params ["_target", "_caller"];
	[_caller] remoteExec ["OA_fnc_jobRequest", 2];
}, [], 9, false, true, "", "!(isNull objectParent _this) && (_this distance (getMarkerPos 'civSpawn') < 1000)"];

_player addAction [ format ["<t color='#00FF00'>Request Refuel (%1)</t>", _formattedRefuelCost], {
	params ["_target", "_caller"];
	["refuel", _caller, vehicle _caller] remoteExec ["OA_fnc_addAirportJob", 2];
}, [], 9, false, true, "", "!(isNull objectParent _this) && (_this distance (getMarkerPos 'civSpawn') < 1000)"];

_player addAction [ format ["<t color='#00FF00'>Request Repair (%1)</t>", _formattedRepairCost], {
	params ["_target", "_caller"];
	["repair", _caller, vehicle _caller] remoteExec ["OA_fnc_addAirportJob", 2];
}, [], 9, false, true, "", "!(isNull objectParent _this) && (_this distance (getMarkerPos 'civSpawn') < 1000)"];
