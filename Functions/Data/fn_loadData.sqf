if (!isServer) exitWith {};

["Loading game state"] call OA_fnc_sendGlobalMsg;
// funds
private _startingFunds = profileNamespace getvariable ["OA_starting_funds", 0];
private _savedFunds = profileNamespace getVariable ["OA_airport_funds", _startingFunds];
missionNamespace setVariable ["OA_airport_funds", _savedFunds, true];
private _playerStartingBalance = profileNamespace getVariable ["OA_player_starting_balance", 0];
missionNamespace setVariable ["OA_player_starting_balance", _playerStartingBalance, true];

// vehicles
private _vehicles = profileNamespace getVariable ["OA_airport_vehicles", []];

if (count _vehicles == 0) then {
    ["B_Heli_Light_01_F", 0.5, 0.5] call OA_fnc_spawnVehicle;
} else {
    {
        _type = _x select 0;
        _pos = [];
        // if only 1 vehicle spawn it nearer to the players
        if (count _vehicles == 1) then {
            _pos = getMarkerPos "vehicleSpawn";
        } else {
            _pos = getMarkerPos (selectRandom (["OA_vehicle_load_point_"] call BIS_fnc_getMarkers));
        };
        _dir = _x select 2;
        _fuel = _x select 3;
        _damage = _x select 4;
        _skins = _x select 5;

        _veh = createVehicle [_type, _pos, [], 0, "NONE"];
        _veh setVehiclePosition [_pos, [], 0, "NONE"];
        _veh setCaptive true;
        _veh setDir _dir;
        _veh setFuel _fuel;
        _veh setDamage _damage;
        _veh setVariable ["OA_airport_vehicle", true];
        { _veh setObjectTextureGlobal [_forEachIndex, _x]; } forEach _skins;
        sleep 0.1;
    } forEach _vehicles;
};

["Game state loaded"] call OA_fnc_sendGlobalMsg;
