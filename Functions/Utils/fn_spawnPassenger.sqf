params ["_group", "_vehicle"];

private _civilianClasses = [
    // Standard Civilians
    "C_man_1",
    "C_man_polo_1_F",
    "C_man_polo_2_F",
    "C_man_polo_3_F",
    "C_man_polo_4_F",
    "C_man_polo_5_F",
    "C_man_polo_6_F",
    "C_man_shorts_1_F",

    // Professionals
    "C_man_w_worker_F",
    "C_scientist_F",
    "C_man_hunter_1_F",
    "C_man_pilot_F",
    "C_journalist_F",
    "C_Paramedic_01_base_F"

/*
    // IDAP (Laws of War)
    "C_IDAP_man_AidWorker_01_F",
    "C_IDAP_man_Paramedic_01_F",
    "C_IDAP_man_CargoWorker_01_F",
    "C_IDAP_man_EOD_01_F",

    // Apex & Contact Regional
    "C_man_sport_1_F",
    "C_Man_casual_1_F",
    "C_Man_1_enoch_F",
    "C_Farmer_01_enoch_F"
*/
];

private _unitType = selectRandom _civilianClasses;
private _unit = _group createUnit [_unitType, _spawnPoint, [], 0, "NONE"];
_unit setBehaviour "CARELESS";
_unit setSpeedMode "FULL";
_unit assignAsCargo _vehicle;

_unit