disableSerialization;

private _listData = [
    ["Passenger Job (1-2 passengers)", "passenger-1-2"],
    ["Passenger Job (3-6 passengers)", "passenger-3-6"],
    ["Passenger Job (4-8 passengers)", "passenger-4-8"],
    ["Passenger Job (6-12 passengers)", "passenger-6-12"],
    // ["Medic Job", "medic"],
    ["Cargo Job (Light)", "cargo-light"],
    ["Cargo Job (Medium)", "cargo-medium"],
    ["Cargo Job (Heavy)", "cargo-heavy"]
];

private _buttonText = 'SELECT JOB';

private _buttonHandler = {
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
};

[_listData, _buttonText, _buttonHandler] call OA_fnc_genericListGUI;