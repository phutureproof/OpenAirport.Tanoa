// funds
private _savedFunds = profileNamespace getVariable ["OA_airport_funds", 500000];
missionNamespace setVariable ["OA_airport_funds", _savedFunds, true];

// vehicles
private _vehicles = profileNamespace getVariable ["OA_airport_vehicles", []];
{
    _type = _x select 0;
    _pos = getMarkerPos (selectRandom (["OA_vehicle_load_point_"] call BIS_fnc_getMarkers));
    _dir = _x select 2;
    _fuel = _x select 3;
    _damage = _x select 4;

    _veh = createVehicle [_type, _pos, [], 0, "NONE"];
    _veh setVehiclePosition [_pos, [], 10, "NONE"];
    _veh setDir _dir;
    _veh setFuel _fuel;
    _veh setDamage _damage;
    sleep 0.5;
} forEach _vehicles;
