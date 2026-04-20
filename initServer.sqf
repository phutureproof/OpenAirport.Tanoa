// load game state
[] call OA_fnc_loadData;

// load configs
[] call OA_fnc_initServerConfig;

// load radio configs 
[] call OA_fnc_initCustomRadioChannels;

// check for presence of ALiVE mod 
if (isClass (configFile >> "CfgPatches" >> "ALiVE_main")) then {
	["ALiVE Mod is loaded, initialising."] call OA_fnc_sendATCmsg;
    [] call OA_fnc_initAlive;
};

// start airport jobs queue
sleep 5;
[] call OA_fnc_airportRefuelJobsQueue;
[] call OA_fnc_airportRepairJobsQueue;