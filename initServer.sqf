// load game state
[] call OA_fnc_loadData;

// define globals
missionNamespace setVariable ["OA_repair_cost", 10000, true];
missionNamespace setVariable ["OA_refuel_cost", 1000, true];

missionNamespace setVariable ["OA_vehicle_object_array", [] call OA_fnc_returnVehicleObjectArray, true];
missionNamespace setVariable ["OA_vehicle_base_price", 40000, true];
missionNamespace setVariable ["OA_vehicle_price_multiplier", 1.08, true];

// start airport jobs queue
sleep 5;
[] call OA_fnc_airportRefuelJobsQueue;
[] call OA_fnc_airportRepairJobsQueue;

