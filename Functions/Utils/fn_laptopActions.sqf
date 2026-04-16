params ["_obj"];


_obj addAction ["<t color='#0000FF'>Show Airport Balance</t>", { [] call OA_fnc_showFunds; }, [], 10, true, true];
_obj addAction ["<t color='#00FF00'>Save Game</t>", { [] remoteExec ["OA_fnc_saveData", 2]; }, [], 10, true, true];


_obj addAction ["<t color='#FF0000'>================</t>", {}, [], 0, true, true];
_obj addAction ["<t color='#FF0000'>!! Reset Game Data !!</t>", {
	[] spawn {
		_result = ['Are you sure you want to reset the game?!', 'RESET GAME DATA', true, true] call BIS_fnc_guiMessage;
		if (_result) then {
			[] remoteExec ["OA_fnc_resetSave", 2];
		};
	};
}, [], 0, true, true];
_obj addAction ["<t color='#FF0000'>================</t>", {}, [], 0, true, true];

