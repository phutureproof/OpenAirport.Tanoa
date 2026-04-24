private _allVehicles = "(configName _x) isKindOf 'Helicopter'" configClasses (configFile >> "CfgVehicles");
private _basePrice = missionNamespace getVariable ["OA_vehicle_base_price", 0];
private _priceMultiplier = missionNamespace getVariable ["OA_vehicle_price_multiplier", 0];

private _vehicleList = [];

{
	_className = (configName _x);
	_scope = getNumber (_x >> 'scope');
	_numSeats = (getNumber (_x >> 'transportSoldier'));
	_factionID = getText (_x >> 'faction');
	_factionName = getText(configFile >> "CfgFactionClasses" >> _factionID >> "displayName");
	_displayName = format ["%1 (%2)", getText (_x >> 'displayName'), _factionName];

	if ( (_scope >= 2) && (_numSeats > 1) ) then {
		_price = (_basePrice * (_priceMultiplier * _numSeats));
		_vehicleList pushBack ["air", _className, _displayName, _numSeats, _price];
	};

} forEach _allVehicles;

_vehicleList = [_vehicleList, [], {_x select 3}, "ASCEND"] call BIS_fnc_sortBy;

_vehicleList