if (!isServer) exitWith {};
if (!isClass (configFile >> "CfgPatches" >> "ALiVE_main")) exitWith {};

["ALiVE Mod is loaded, initialising."] call OA_fnc_sendATCmsg;
private _aliveGroup = createGroup sideLogic;

["Creating ALiVE require system."] call OA_fnc_sendATCmsg;
"ALiVE_require" createUnit [[0,0,0], _aliveGroup, '
	this setVariable ["ALiVE_GC_THRESHHOLD", "100", true];
	this setVariable ["ALiVE_GC_INTERVAL", "300", true];
	this setVariable ["ALiVE_DISABLEADMINACTIONS", false, true];
	this setVariable ["ALiVE_Versioning", "warning", true];
	this setVariable ["debug", "false", true];
	this setVariable ["ALiVE_PAUSEMODULES", false, true];
	this setVariable ["ALiVE_GC_INDIVIDUALTYPES", "", true];
	this setVariable ["ALiVE_TABLET_MODEL", "Tablet01", true];
	this setVariable ["ALiVE_DISABLEMARKERS", false, true];
	this setVariable ["ALiVE_DISABLESAVE", "true", true];
	this setVariable ["ALiVE_AI_DISTRIBUTION", "false", true];
	this setVariable ["BIS_fnc_initModules_disableAutoActivation", false];
'];
sleep 3;

["Creating ALiVE system profile."] call OA_fnc_sendATCmsg;
"ALiVE_sys_profile" createUnit [[0,0,0], _aliveGroup, '
	this setVariable ["virtualcombat_speedmodifier", "0.75", true];
	this setVariable ["spawnTypeJetRadius", "2500", true];
	this setVariable ["seaTransport", "false", true];
	this setVariable ["pathfinding", "false", true];
	this setVariable ["debug", "false", true];
	this setVariable ["activeLimiter", "50", true];
	this setVariable ["spawnRadius", "1000", true];
	this setVariable ["persistent", "false", true];
	this setVariable ["speedModifier", "1.00", true];
	this setVariable ["syncronised", "ADD", true];
	this setVariable ["smoothSpawn", "0.3", true];
	this setVariable ["spawnRadiusUAV", "-1", true];
	this setVariable ["zeusSpawn", "true", true];
	this setVariable ["spawnTypeHeliRadius", "2500", true];
	this setVariable ["pathfindingSize", "[600,75]", true];
	this setVariable ["BIS_fnc_initModules_disableAutoActivation", false];
'];
sleep 1;

["Creating ALiVE weather system."] call OA_fnc_sendATCmsg;
"ALiVE_sys_weather" createUnit[[0,0,0], _aliveGroup, '
	this setVariable ["weather_cycle_variance_setting", 0.5, true];
	this setVariable ["weather_debug_cycle_setting", 60, true];
	this setVariable ["weather_real_location_setting", "COUNTRY/CITY", true];
	this setVariable ["weather_initial_setting", 2, true];
	this setVariable ["weather_debug_setting", "false", true];
	this setVariable ["weather_cycle_delay_setting", 1800, true];
	this setVariable ["weather_override_setting", 3, true];
	this setVariable ["BIS_fnc_initModules_disableAutoActivation", false];
'];
sleep 1;

/*

["Creating ALiVE civilian population system."] call OA_fnc_sendATCmsg;
"ALiVE_amb_civ_population" createUnit [[0,0,0], _aliveGroup, '
	this setVariable ["disableACEX", 0, true];
	this setVariable ["ambientCrowdSpawn", "50", true];
	this setVariable ["humanitarianHostilityChance", "20", true];
	this setVariable ["ambientCrowdFaction", "", true];
	this setVariable ["insurgentFaction", "", true];
	this setVariable ["spawnRadius", "1000", true];
	this setVariable ["customHumRatItems", "", true];
	this setVariable ["hostilityWest", "0", true];
	this setVariable ["activeLimiter", "10", true];
	this setVariable ["hostilityIndep", "0", true];
	this setVariable ["spawnTypeJetRadius", "2500", true];
	this setVariable ["ambientCivilianRoles", "[]", true];
	this setVariable ["limitInteraction", "", true];
	this setVariable ["enableInteraction", "false", true];
	this setVariable ["ambientCrowdLimit", "50", true];
	this setVariable ["spawnTypeHeliRadius", "2500", true];
	this setVariable ["debug", "false", true];
	this setVariable ["ambientCrowdDensity", "3", true];
	this setVariable ["hostilityEast", "0", true];
	this setVariable ["maxAllowAid", "3", true];
	this setVariable ["customWaterItems", "", true];
	this setVariable ["BIS_fnc_initModules_disableAutoActivation", false];
'];
sleep 1;

["Creating ALiVE civilian placement system."] call OA_fnc_sendATCmsg;
"ALiVE_amb_civ_placement" createUnit [[0,0,0], _aliveGroup, '
	this setVariable ["taor", "", true];
	this setVariable ["initialdamage", "false", true];
	this setVariable ["sizeFilter", "400", true];
	this setVariable ["blacklist", "", true];
	this setVariable ["debug", "false", true];
	this setVariable ["ambientVehicleFaction", "CIV_F", true];
	this setVariable ["faction", "CIV_F", true];
	this setVariable ["placementMultiplier", "1", true];
	this setVariable ["ambientVehicleAmount", "0.6", true];
	this setVariable ["priorityFilter", "", true];
	this setVariable ["BIS_fnc_initModules_disableAutoActivation", false];
'];

*/
