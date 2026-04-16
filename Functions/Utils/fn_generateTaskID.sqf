params ["_player"];

[time] remoteExec ["hint"];
private _taskID = format ["job-%1-%2", name _player, round(random(9999999))];

_taskID