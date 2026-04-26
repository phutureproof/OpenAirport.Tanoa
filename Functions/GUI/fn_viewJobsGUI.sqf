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
            [] spawn {
                [player] remoteExec ["OA_fnc_passengerJobRequest", 2];
            };
        };
        case "parachute": {
            [] spawn {
                [player] remoteExec ["OA_fnc_parachuteJobRequest", 2];
            };
        };
        case "cargo": {
            _weight = _jobParams select 1;
            [_weight] spawn {
                params ["_weight"];
                [player, _weight] remoteExec ["OA_fnc_cargoJobRequest", 2];
            };
        };
        case "medic": {
            [] spawn {
                [player] remoteExec ["OA_fnc_medicJobRequest", 2];
            };
        };
        default {
            hint "Not implemented yet";
        };
    };
    
};

[_listData, _buttonText, _buttonHandler] call OA_fnc_genericListGUI;
