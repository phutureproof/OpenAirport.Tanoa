params ["_obj"];

private _menuPriority = 20;

_obj addAction ["<t color='#11c94e'>Show Airport Balance</t>", { [] call OA_fnc_showFunds; }, [], _menuPriority, true, true];
_obj addAction ["<t color='#11c94e'>View Jobs</t>", { [] call OA_fnc_viewJobGUI; }, [], _menuPriority, true, true];
_obj addAction ["================", { }, [], _menuPriority, true, true];
_obj addAction ["<t color='#12c7df'>Save Game</t>", { [] remoteExec ["OA_fnc_saveData", 2]; }, [], _menuPriority, true, true];
_obj addAction ["================", {}, [], _menuPriority, true, true];
_obj addAction ["<t color='#FF0000'>!! Reset Game Data !!</t>", {
	[] spawn {
		_result = ['Are you sure you want to reset the game?!', 'RESET GAME DATA', true, true] call BIS_fnc_guiMessage;
		if (_result) then {
			[] remoteExec ["OA_fnc_resetSave", 2];
		};
	};
}, [], _menuPriority, true, true];
_obj addAction ["================", {}, [], _menuPriority, true, true];