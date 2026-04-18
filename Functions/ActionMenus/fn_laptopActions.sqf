params ["_obj"];

private _menuPriority = 20;

_obj addAction ["<t color='#11c94e'>Laptop Menu</t>", {}, [], _menuPriority, true, false, "", "true", 3];
_obj addAction ["================", { }, [], _menuPriority, true, true, "", "true", 3];
_obj addAction ["<t color='#11c94e'>View Helicopter Jobs</t>", { [] call OA_fnc_viewHelicopterJobGUI; }, [], _menuPriority, true, true, "", "true", 3];
_obj addAction ["<t color='#11c94e'>View Plane Jobs</t>", { [] call OA_fnc_viewPlaneJobGUI; }, [], _menuPriority, true, true, "", "true", 3];
_obj addAction ["================", { }, [], _menuPriority, true, true, "", "true", 3];
_obj addAction ["<t color='#12c7df'>Save Game</t>", { [] remoteExec ["OA_fnc_saveData", 2]; }, [], _menuPriority, true, true, "", "true", 3];
_obj addAction ["================", {}, [], _menuPriority, true, true, "", "true", 3];
_obj addAction ["<t color='#FF0000'>!! Reset Game Data !!</t>", {
	[] spawn {
		_result = ['Are you sure you want to reset the game?!', 'RESET GAME DATA', true, true] call BIS_fnc_guiMessage;
		if (_result) then {
			[] remoteExec ["OA_fnc_resetSave", 2];
		};
	};
}, [], _menuPriority, true, true, "", "true", 3];
_obj addAction ["================", {}, [], _menuPriority, true, true, "", "true", 3];