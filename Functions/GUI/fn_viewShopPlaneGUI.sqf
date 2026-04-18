private _vehicleObjectArray = missionNamespace getVariable ["OA_shop_plane_array", []];

private _listData = _vehicleObjectArray apply {
    private _type = _x select 0;
    private _className = _x select 1;
    private _friendlyName = _x select 2;
    private _seats = _x select 3;
    private _price = _x select 4;

    private _formattedPrice = [_price] call OA_fnc_formatIntAsCurrency;

    private _buttonText = format ["%1 | %2 seats | %3", _friendlyName, _seats, _formattedPrice];
    private _dataString = format ["%1|%2|%3", _className, _friendlyName, _price];

    [_buttonText, _dataString]
};

private _buttonText = 'PURCHASE VEHICLE';

private _buttonHandler = {
    params ["_itemName", "_itemData"];

    private _vehicleParams = _itemData splitString "|";
    private _vehicleClassName = _vehicleParams select 0;
    private _vehicleFriendlyName = _vehicleParams select 1;
    private _vehiclePrice = parseNumber (_vehicleParams select 2);

    private _callingPlayerName = name player;
    
    [_callingPlayerName, _vehicleClassName, _vehicleFriendlyName, _vehiclePrice] remoteExec ["OA_fnc_purchaseVehicle", 2];
};

[_listData, _buttonText, _buttonHandler] call OA_fnc_genericListGUI;