[] spawn {
	while {true} do {
		// this is a queue of units waiting for a move command
		_queue = missionNamespace getVariable ["OA_airport_traffic_queue", []];

		if (count(_queue) > 0) then {
			
			_group = _queue select 0;

			// spawn this on a new thread so the queue continues
			[_group] spawn {
				params ["_group"];

				_veh = vehicle (leader _group);

				_dest = [] call OA_fnc_getRandomHelicopterDestination;

				_group setBehaviour "CARELESS";
				_group setCombatMode "BLUE";

				_veh setCaptive true;
				_veh flyInHeight 100;

				_wp = _group addWaypoint [_dest, 0];
				_wp setWaypointType "MOVE";
				_wp setWaypointSpeed "NORMAL";
				_wp setWaypointCompletionRadius 100;

				waitUntil {
					(_veh distance2D _dest < 250)
				};

				_veh setFuel 1;
				_veh setDamage 0;

				[_group] call OA_fnc_addTrafficToQueue;
			};
			_queue deleteAt 0;
			missionNameSpace setVariable ["OA_airport_traffic_queue", _queue, true];

		};
		sleep 1;
	};
};
