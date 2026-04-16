params ["_player", "_title", "_description", "_position", "_type"];

private _taskID = [_player] call OA_fnc_generateTaskID;
[
        _player,
        _taskID,
        [
            _description,
            _title
        ],
        _position,
        "ASSIGNED",
        2,
        true,
        _type,
        true
    ] call BIS_fnc_taskCreate;

_taskID