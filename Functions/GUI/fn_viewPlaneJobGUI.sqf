private _listData = [
    ["Passenger Job (1-2 passengers)", "passenger-1-2"],
    ["Parachute Job (1-2 passengers)", "parachute-1-2"]
];

private _buttonText = 'SELECT JOB';

private _buttonHandler = {
    params ["_itemName", "_itemData"];

    _jobParams = _itemData splitString "-";
    _jobType = _jobParams select 0;
    
    switch (_jobType) do {
        case "passenger": {
            _min = parseNumber (_jobParams select 1);
            _max = parseNumber (_jobParams select 2);
            [player, _min, _max] remoteExec ["OA_fnc_passengerPlaneJobRequest", 2];
        };
        case "parachute": {
            _min = parseNumber (_jobParams select 1);
            _max = parseNumber (_jobParams select 2);
            [player, _min, _max] remoteExec ["OA_fnc_parachutePlaneJobRequest", 2];
        };
        default {
            hint "Not yet implemented";
        };
    };
    
};

[_listData, _buttonText, _buttonHandler] call OA_fnc_genericListGUI;