// load game state
[] call OA_fnc_loadData;

// define globals
missionNamespace setVariable ["OA_repair_cost", 10000, true];
missionNamespace setVariable ["OA_refuel_cost", 1000, true];

// start airport jobs queue
sleep 5;
[] call OA_fnc_airportRefuelJobsQueue;
[] call OA_fnc_airportRepairJobsQueue;

