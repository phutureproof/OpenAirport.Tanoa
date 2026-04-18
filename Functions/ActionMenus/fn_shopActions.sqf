params ["_obj"];

private _menuPriority = 20;

_obj addAction ["<t color='#11c94e'>Purchase Helicopter</t>", { [] call OA_fnc_viewShopGUI; }, [], _menuPriority, true, true];
_obj addAction ["================", {}, [], _menuPriority, true, true];
