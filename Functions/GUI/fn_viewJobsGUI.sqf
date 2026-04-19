private _listData = [
    ["Passenger Job", "passenger"],
    ["Parachute Job", "parachute"],
    ["Medic Job", "medic"],
    ["Cargo Job (Light)", "cargo-light"],
    ["Cargo Job (Medium)", "cargo-medium"],
    ["Cargo Job (Heavy)", "cargo-heavy"]
];

private _buttonText = 'SELECT JOB';

private _buttonHandler = {
    params ["_itemName", "_itemData"];

    _jobParams = _itemData splitString "-";
    _jobType = _jobParams select 0;
    
    switch (_jobType) do {
        case "passenger": {
            [player] remoteExec ["OA_fnc_passengerJobRequest", 2];
        };
        case "parachute": {
            [player] remoteExec ["OA_fnc_parachuteJobRequest", 2];
        };
        case "cargo": {
            _weight = _jobParams select 1;
            [player, _weight] remoteExec ["OA_fnc_cargoHelicopterJobRequest", 2];
        };
        default {
            hint "Not implemented yet";
        };
    };
    
};

[_listData, _buttonText, _buttonHandler] call OA_fnc_genericListGUI;
