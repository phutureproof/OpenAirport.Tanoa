params ["_listData", "_buttonText", "_buttonHandler"];

disableSerialization;

// create background
private _display = findDisplay 46 createDisplay "RscDisplayEmpty";
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
_btn ctrlAddEventHandler ["ButtonClick", _buttonHandler];