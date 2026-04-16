params ["_listData", "_buttonText", "_buttonHandler"];

disableSerialization;

// create background
private _display = findDisplay 46 createDisplay "RscDisplayEmpty";
_display setVariable ["_buttonHandler", _buttonHandler];

private _bg = _display ctrlCreate ["RscText", -1];
_bg ctrlSetPosition [0.35 * safeZoneW + safeZoneX, 0.3 * safeZoneH + safeZoneY, 0.3 * safeZoneW, 0.4 * safeZoneH];
_bg ctrlSetBackgroundColor [0, 0, 0, 0.8];
_bg ctrlCommit 0;

// create the list box of jobs
private _list = _display ctrlCreate ["RscListBox", 1500];
_list ctrlSetPosition [0.36 * safeZoneW + safeZoneX, 0.32 * safeZoneH + safeZoneY, 0.28 * safeZoneW, 0.3 * safeZoneH];
_list ctrlCommit 0;

// add _listData to the list
{
    private _index = _list lbAdd (_x select 0); // Display Name
    _list lbSetData [_index, _x select 1];    // Hidden ID (Code-friendly)
} forEach _listData;

// Select button
private _btn = _display ctrlCreate ["RscButton", -1];
_btn ctrlSetPosition [0.45 * safeZoneW + safeZoneX, 0.63 * safeZoneH + safeZoneY, 0.1 * safeZoneW, 0.05 * safeZoneH];
_btn ctrlSetText _buttonText;
_btn ctrlCommit 0;

// event handlers
_btn ctrlAddEventHandler ["ButtonClick", {
    params ["_ctrl"];
    private _display = ctrlParent _ctrl;
    private _buttonHandler = _display getVariable["_buttonHandler", {}];

    private _list = _display displayCtrl 1500;
    private _selIdx = lbCurSel _list;

    if (_selIdx == -1) exitWith { hint "Please make a selection first"; };

    private _itemName = _list lbText _selIdx;
    private _itemData = _list lbData _selIdx;

    [_itemName, _itemData] call _buttonHandler;

    _display closeDisplay 1;
    _display setVariable ["_buttonHandler", nil];
}];