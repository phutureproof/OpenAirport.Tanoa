[] spawn {
	while {true} do {
		_queue = missionNamespace getVariable ["OA_airport_repair_jobs", []];

		if (count(_queue) > 0) then {
			_job = _queue select 0;
			_jobType = _job select 0;
			_player = _job select 1;
			_target = _job select 2;

			switch (_jobType) do {
				case "repair": {
					waitUntil {
						sleep 1;
						_result = [_player, _target] call OA_fnc_repairJob;
						_result
					};
				};
			};

			_queue deleteAt 0;
			missionNameSpace setVariable ["OA_airport_repair_jobs", _queue, true];
		};
		sleep 1;
	};
};
