params ["_obj"];

private _menuPriority = 20;

_obj addAction ["<t color='#11c94e'>View Shop</t>", { [] call OA_fnc_viewShopGUI; }, [], _menuPriority, true, true];