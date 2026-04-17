params ["_player"];

private _allVehicles = "true" configClasses (configFile >> "CfgVehicles");
private _listData = [];
private _priceMultiplier = 50000; // per seat multiplier example

{
	_className = (configName _x);
	_scope = getNumber (_x >> 'scope');
	_numSeats = getNumber (_x >> 'transportSoldier');
	_displayName = getText (_x >> 'displayName');

	if ( (_className isKindOf 'Helicopter') && (_scope >= 2) && _numSeats > 0) then {
		_price = [(_numSeats * _priceMultiplier)] call OA_fnc_formatIntAsCurrency;
		_listData pushBack [
			format [
				"%1 %2 passengers (%3)",
				_displayName,
				_numSeats,
				_price
			],
			format ["%1-%2-%3", _className, _numSeats, _price]
		];
	};
} forEach _allVehicles;

private _buttonText = 'SELECT VEHICLE';

private _buttonHandler = {
    params ["_itemName", "_itemData"];
    
	hint format ["You selected %1", _itemData];
};

[_listData, _buttonText, _buttonHandler] remoteExec ["OA_fnc_genericListGUI", owner _player];