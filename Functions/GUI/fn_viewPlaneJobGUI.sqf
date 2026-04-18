private _listData = [
    ["Passenger Job", "passenger"],
    ["Parachute Job", "parachute"]
];

private _buttonText = 'SELECT JOB';

private _buttonHandler = {
    params ["_itemName", "_itemData"];

    _jobParams = _itemData splitString "-";
    _jobType = _jobParams select 0;
    
    switch (_jobType) do {
        case "passenger": {
            [player] remoteExec ["OA_fnc_passengerPlaneJobRequest", 2];
        };
        case "parachute": {
            [player] remoteExec ["OA_fnc_parachutePlaneJobRequest", 2];
        };
        default {
            hint "Not yet implemented";
        };
    };
    
};

[_listData, _buttonText, _buttonHandler] call OA_fnc_genericListGUI;