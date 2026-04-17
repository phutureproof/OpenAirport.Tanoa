private _allVehicles = "true" configClasses (configFile >> "CfgVehicles");
private _basePrice = missionNamespace getVariable ["OA_vehicle_base_price", 0];
private _priceMultiplier = missionNamespace getVariable ["OA_vehicle_price_multiplier", 0];

private _vehicleObjectArray = [];

{
	_className = (configName _x);
	_scope = getNumber (_x >> 'scope');
	_numSeats = getNumber (_x >> 'transportSoldier');
	_displayName = getText (_x >> 'displayName');

	if ( (_className isKindOf 'Helicopter') && (_scope >= 2) && _numSeats > 0) then {
		_price = (_basePrice * (_priceMultiplier * _numSeats));
		_vehicleObjectArray pushBack ["air", _className, _displayName, _numSeats, _price];
	};

} forEach _allVehicles;

_vehicleObjectArray