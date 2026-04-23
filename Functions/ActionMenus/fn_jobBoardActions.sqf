params ["_obj"];

private _menuPriority = 20;

_obj addAction ["<t color='#11c94e'>View Jobs</t>", { [] call OA_fnc_viewJobsGUI; }, [], _menuPriority, true, true, "", "true", 3];
_obj addAction ["================", { }, [], _menuPriority, true, false, "", "true", 3];
