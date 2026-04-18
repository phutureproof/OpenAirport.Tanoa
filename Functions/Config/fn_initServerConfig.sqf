// define configs for game mode 

// refuel / repair job costs
missionNamespace setVariable ["OA_repair_cost", 10000, true];
missionNamespace setVariable ["OA_refuel_cost", 1000, true];

// shop vehicle
missionNamespace setVariable ["OA_vehicle_base_price", 40000, true]; // Must be set before the OA_vehicle_object_array
missionNamespace setVariable ["OA_vehicle_price_multiplier", 1.08, true]; // Must be set before the OA_vehicle_object_array
missionNamespace setVariable ["OA_shop_helicopter_array", [] call OA_fnc_shopHelicopterList, true]; // This must load last