private _allVehicles = "(configName _x) isKindOf 'Plane'" configClasses (configFile >> "CfgVehicles");
private _basePrice = missionNamespace getVariable ["OA_vehicle_base_price", 0];
private _priceMultiplier = missionNamespace getVariable ["OA_vehicle_price_multiplier", 0];

private _vehicleList = [];

{
	_className = (configName _x);
	_scope = getNumber (_x >> 'scope');
	_numSeats = (getNumber (_x >> 'transportSoldier'));
	_numTurrets = count ("true" configClasses (_x >> 'Turrets'));
	_totalSeats = (_numSeats + _numTurrets) - 1;
	_factionID = getText (_x >> 'faction');
	_factionName = getText(configFile >> "CfgFactionClasses" >> _factionID >> "displayName");
	_displayName = format ["%1 (%2)", getText (_x >> 'displayName'), _factionName];

	if ( (_scope >= 2) && (_totalSeats > 1) ) then {
		_price = (_basePrice * (_priceMultiplier * _totalSeats));
		_vehicleList pushBack ["air", _className, _displayName, _totalSeats, _price];
	};

} forEach _allVehicles;

_vehicleList = [_vehicleList, [], {_x select 3}, "ASCEND"] call BIS_fnc_sortBy;

_vehicleList