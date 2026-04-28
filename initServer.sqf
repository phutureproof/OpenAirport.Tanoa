// load configs
[] call OA_fnc_initServerConfig;

// load radio configs 
[] call OA_fnc_initCustomRadioChannels;

// start airport jobs queue
[] call OA_fnc_airportRefuelJobsQueue;
[] call OA_fnc_airportRepairJobsQueue;
[] call OA_fnc_ambTrafficQueue;

// load game state
[] call OA_fnc_loadData;

OA_server_init_done = true;
