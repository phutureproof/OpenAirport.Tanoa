params ["_obj"];

private _menuPriority = 20;

_obj addAction ["<t color='#11c94e'>Shop Menu</t>", {}, [], _menuPriority, true, false, "", "true", 3];
_obj addAction ["================", { }, [], _menuPriority, true, true, "", "true", 3];
_obj addAction ["<t color='#11c94e'>Purchase Helicopter</t>", { [] call OA_fnc_viewShopHelicopterGUI; }, [], _menuPriority, true, true, "", "true", 3];
_obj addAction ["<t color='#11c94e'>Purchase Plane</t>", { [] call OA_fnc_viewShopPlaneGUI; }, [], _menuPriority, true, true, "", "true", 3];
_obj addAction ["================", {}, [], _menuPriority, true, true, "", "true", 3];
