params ["_obj"];

private _menuPriority = 20;

_obj addAction ["<t color='#11c94e'>Laptop Menu</t>", {}, [], _menuPriority, true, false, "", "true", 3];
_obj addAction ["================", { }, [], _menuPriority, true, false, "", "true", 3];
_obj addAction ["<t color='#00FF00'>Show Airport Balance</t>", {
	params ["_target", "_caller"];
	[] call OA_fnc_showFunds;
}, [], _menuPriority, false, true];
_obj addAction ["<t color='#00FF00'>View Jobs</t>", { [] call OA_fnc_viewJobsGUI; }, [], _menuPriority, true, true, "", "true", 3];
_obj addAction ["================", { }, [], _menuPriority, true, false, "", "true", 3];
_obj addAction ["<t color='#00FF00'>Save Game</t>", { [] remoteExec ["OA_fnc_saveData", 2]; }, [], _menuPriority, true, true, "", "true", 3];
_obj addAction ["================", {}, [], _menuPriority, true, false, "", "true", 3];
_obj addAction ["<t color='#FF0000'>!! Reset Game Data !!</t>", {
	[] spawn {
		_result = ['Are you sure you want to reset the game?!', 'RESET GAME DATA', true, true] call BIS_fnc_guiMessage;
		if (_result) then {
			[] remoteExec ["OA_fnc_resetSave", 2];
		};
	};
}, [], _menuPriority, true, true, "", "true", 3];
_obj addAction ["================", {}, [], _menuPriority, true, false, "", "true", 3];