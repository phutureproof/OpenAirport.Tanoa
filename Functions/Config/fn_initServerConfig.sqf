// define configs for game mode 
missionNamespace setVariable ["OA_starting_funds", 0, true];

// refuel / repair job costs
missionNamespace setVariable ["OA_repair_cost", 10000, true];
missionNamespace setVariable ["OA_refuel_cost", 1000, true];

// shop vehicle
missionNamespace setVariable ["OA_vehicle_base_price", 40000, true]; // Must be set before the OA_vehicle_object_array
missionNamespace setVariable ["OA_vehicle_price_multiplier", 1.08, true]; // Must be set before the OA_vehicle_object_array
missionNamespace setVariable ["OA_shop_helicopter_array", [] call OA_fnc_shopHelicopterList, true]; // This must load last
missionNamespace setVariable ["OA_shop_plane_array", [] call OA_fnc_shopPlaneList, true]; // This must load last

// civilians
private _allCivilians = "(configName _x) isKindOf 'Civilian'" configClasses (configFile >> "CfgVehicles");
private _civilianClasses = [];
{ _civilianClasses pushBack (configName _x); } forEach _allCivilians;
missionNamespace setVariable ["OA_civilianList", _civilianClasses, true];
