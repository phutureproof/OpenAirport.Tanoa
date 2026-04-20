if (isServer) then {

	private _aliveGroup = createGroup sideLogic;
	
	["Creating ALiVE main system."] call OA_fnc_sendATCmsg;
	private _main = _aliveGroup createUnit ["ALiVE_main", [0,0,0], [], 0, "NONE"];

	["Creating ALiVE require system."] call OA_fnc_sendATCmsg;
	private _require = _aliveGroup createUnit ["ALiVE_require", [0,0,0], [], 0, "NONE"];
	_require setVariable ['ALiVE_GC_THRESHHOLD', "100", true];
	_require setVariable ['ALiVE_GC_INTERVAL', "300", true];
	_require setVariable ['ALiVE_DISABLEADMINACTIONS', 0, true];
	_require setVariable ['ALiVE_Versioning', "warning", true];
	_require setVariable ['debug', "false", true];
	_require setVariable ['ALiVE_PAUSEMODULES', 0, true];
	_require setVariable ['ALiVE_GC_INDIVIDUALTYPES', "", true];
	_require setVariable ['ALiVE_TABLET_MODEL', "Tablet01", true];
	_require setVariable ['ALiVE_DISABLEMARKERS', 0, true];
	_require setVariable ['ALiVE_DISABLESAVE', "true", true];
	_require setVariable ['ALiVE_AI_DISTRIBUTION', "false", true];

	["Creating ALiVE system profile."] call OA_fnc_sendATCmsg;
	private _sysProfile = _aliveGroup createUnit ["ALiVE_sys_profile", [0,0,0], [], 0, "NONE"];
	_sysProfile setVariable ['virtualcombat_speedmodifier', "0.75", true];
	_sysProfile setVariable ['spawnTypeJetRadius', "2500", true];
	_sysProfile setVariable ['seaTransport', "false", true];
	_sysProfile setVariable ['pathfinding', "false", true];
	_sysProfile setVariable ['debug', "false", true];
	_sysProfile setVariable ['activeLimiter', "144", true];
	_sysProfile setVariable ['spawnRadius', "1000", true];
	_sysProfile setVariable ['persistent', "false", true];
	_sysProfile setVariable ['speedModifier', "1.00", true];
	_sysProfile setVariable ['syncronised', "ADD", true];
	_sysProfile setVariable ['smoothSpawn', "0.3", true];
	_sysProfile setVariable ['spawnRadiusUAV', "-1", true];
	_sysProfile setVariable ['zeusSpawn', "true", true];
	_sysProfile setVariable ['spawnTypeHeliRadius', "2500", true];
	_sysProfile setVariable ['pathfindingSize', "[600,75]", true];
	
	["Creating ALiVE weather system."] call OA_fnc_sendATCmsg;
	private _weather = _aliveGroup createUnit ["ALiVE_sys_weather", [0,0,0], [], 0, "NONE"];
	_weather setVariable ['weather_cycle_variance_setting', 0.5 , true];
	_weather setVariable ['weather_debug_cycle_setting', 60, true];
	_weather setVariable ['weather_real_location_setting', "COUNTRY/CITY", true];
	_weather setVariable ['weather_initial_setting', 2, true];
	_weather setVariable ['weather_debug_setting', "false", true];
	_weather setVariable ['weather_cycle_delay_setting', 1800, true];
	_weather setVariable ['weather_override_setting', 3, true];

	["Creating ALiVE civilian population system."] call OA_fnc_sendATCmsg;
	private _civPop = _aliveGroup createUnit ["ALiVE_amb_civ_population", [0,0,0], [], 0, "NONE"];
	_civPop setVariable ['disableACEX', 0, true];
	_civPop setVariable ['ambientCrowdSpawn', "50", true];
	_civPop setVariable ['humanitarianHostilityChance', "20", true];
	_civPop setVariable ['ambientCrowdFaction', "", true];
	_civPop setVariable ['insurgentFaction', "", true];
	_civPop setVariable ['spawnRadius', "1000", true];
	_civPop setVariable ['customHumRatItems', "", true];
	_civPop setVariable ['hostilityWest', "0", true];
	_civPop setVariable ['activeLimiter', "50", true];
	_civPop setVariable ['hostilityIndep', "0", true];
	_civPop setVariable ['spawnTypeJetRadius', "2500", true];
	_civPop setVariable ['ambientCivilianRoles', "[]", true];
	_civPop setVariable ['limitInteraction', "", true];
	_civPop setVariable ['enableInteraction', "false", true];
	_civPop setVariable ['ambientCrowdLimit', "50", true];
	_civPop setVariable ['spawnTypeHeliRadius', "2500", true];
	_civPop setVariable ['debug', "false", true];
	_civPop setVariable ['ambientCrowdDensity', "3", true];
	_civPop setVariable ['hostilityEast', "0", true];
	_civPop setVariable ['maxAllowAid', "3", true];
	_civPop setVariable ['customWaterItems', "", true];

	["Creating ALiVE civilian placement system."] call OA_fnc_sendATCmsg;
	private _civPlacement = _aliveGroup createUnit ["ALiVE_amb_civ_population", [0,0,0], [], 0, "NONE"];
	_civPlacement setVariable ['taor', "", true];
	_civPlacement setVariable ['initialdamage', "false", true];
	_civPlacement setVariable ['sizeFilter', "400", true];
	_civPlacement setVariable ['blacklist', "", true];
	_civPlacement setVariable ['debug', "false", true];
	_civPlacement setVariable ['ambientVehicleFaction', "CIV_F", true];
	_civPlacement setVariable ['faction', "CIV_F", true];
	_civPlacement setVariable ['placementMultiplier', "1", true];
	_civPlacement setVariable ['ambientVehicleAmount', "0.6", true];
	_civPlacement setVariable ['priorityFilter', "", true];
};