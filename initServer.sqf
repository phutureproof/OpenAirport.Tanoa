// load game state
[] call OA_fnc_loadData;

// load configs
[] call OA_fnc_initServerConfig;

// load radio configs 
[] call OA_fnc_initCustomRadioChannels;

// start airport jobs queue
sleep 5;
[] call OA_fnc_airportRefuelJobsQueue;
[] call OA_fnc_airportRepairJobsQueue;