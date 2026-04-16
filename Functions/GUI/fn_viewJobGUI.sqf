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

// add jobs to the list
private _jobs = [
    ["Passenger Job (1-2 passengers)", "passenger-1-2"],
    ["Passenger Job (3-6 passengers)", "passenger-3-6"],
    ["Passenger Job (4-8 passengers)", "passenger-4-8"],
    ["Passenger Job (6-12 passengers)", "passenger-6-12"],
    // ["Medic Job", "medic"],
    ["Cargo Job (Light)", "cargo-light"],
    ["Cargo Job (Medium)", "cargo-medium"],
    ["Cargo Job (Heavy)", "cargo-heavy"]
];
{
    private _index = _list lbAdd (_x select 0); // Display Name
    _list lbSetData [_index, _x select 1];    // Hidden ID (Code-friendly)
} forEach _jobs;

// Select button
private _btn = _display ctrlCreate ["RscButton", -1];
_btn ctrlSetPosition [0.45 * safeZoneW + safeZoneX, 0.63 * safeZoneH + safeZoneY, 0.1 * safeZoneW, 0.05 * safeZoneH];
_btn ctrlSetText "SELECT JOB";
_btn ctrlCommit 0;

// event handlers
_btn ctrlAddEventHandler ["ButtonClick", {
    params ["_ctrl"];
    private _display = ctrlParent _ctrl;
    private _list = _display displayCtrl 1500;
    private _selIdx = lbCurSel _list;

    if (_selIdx == -1) exitWith { hint "Please select a job first!"; };

    private _jobName = _list lbText _selIdx;
    private _jobID = _list lbData _selIdx;

    _jobParams = _jobID splitString "-";
    _jobType = _jobParams select 0;
    
    switch (_jobType) do {
        case "passenger": {
            _min = parseNumber (_jobParams select 1);
            _max = parseNumber (_jobparams select 2);
            [player, _min, _max] remoteExec ["OA_fnc_passengerJobRequest", 2];
        };
        case "medic": {
            [player] remoteExec ["OA_fnc_medicJobRequest", 2];
        };
        case "cargo": {
            _weight = _jobParams select 1;
            [player, _weight] remoteExec ["OA_fnc_cargoJobRequest", 2];
        };
        default {
            hint "Not yet implemented";
        };
    };
    _display closeDisplay 1;
}];