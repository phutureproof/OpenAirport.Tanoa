// load game state
// funds
private _savedFunds = profileNamespace getVariable ["OA_airport_funds", 100000];
missionNamespace setVariable ["OA_airport_funds", _savedFunds, true];

// define globals
missionNamespace setVariable ["OA_repair_cost", 10000, true];
missionNamespace setVariable ["OA_refuel_cost", 1000, true];

// vehicles
private _vehicles = profileNamespace getVariable ["OA_airport_vehicles", []];
{
    _type = _x select 0;
    _pos = _x select 1;
    _dir = _x select 2;
    _fuel = _x select 3;
    _damage = _x select 4;

    _veh = createVehicle [_type, _pos, [], 0, "CAN_COLLIDE"];
    _veh setPosASL _pos;
    _veh setDir _dir;
    _veh setFuel _fuel;
    _veh setDamage _damage;
} forEach _vehicles;

// start airport jobs queue
sleep 5;
[] call OA_fnc_airportRefuelJobsQueue;
[] call OA_fnc_airportRepairJobsQueue;
