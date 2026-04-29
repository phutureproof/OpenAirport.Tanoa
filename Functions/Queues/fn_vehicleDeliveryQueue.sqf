[] spawn {
	["Starting vehicle delivery job queue"] call OA_fnc_sendGlobalMsg;
	while {true} do {
		_queue = missionNamespace getVariable ["OA_airport_delivery_jobs", []];

		if (count(_queue) > 0) then {

			_job = _queue select 0;
			_job params ["_vehicle"];

			private _spawnPos = [getMarkerPos "vehicleSpawn", 2500, 3000, 1, 50, 0, 0] call BIS_fnc_findSafePos;
			_spawnPos set [2, 40];
			private _dropPos = getMarkerPos "vehicleSpawn";
			private _heliClass = "B_Heli_Transport_03_F"; 
			private _crateClass = "B_Slingload_01_Cargo_F"; 
			private _side = west;

			private _spawnResult = [_spawnPos, 0, _heliClass, _side] call BIS_fnc_spawnVehicle;
			private _heli = _spawnResult select 0;
			private _group = _spawnResult select 2;

			private _crate = createVehicle [_crateClass, _heli modelToWorld [0, 0, -15], [], 0, "NONE"];

			clearWeaponCargoGlobal _crate;
			clearMagazineCargoGlobal _crate;
			clearItemCargoGlobal _crate;
			clearBackpackCargoGlobal _crate;

			[[_crate, _vehicle], {
				params ["_crate", "_vehicle"];
				_crate addAction ["<t color='#00FF00'>Open Crate</t>", {
					params ["_target", "_caller", "_actionID", "_args"];
					_position = getPos _target;
					_direction = getDir _target;
					_args params ["_vehicle"];
					["You have 5 seconds to clear the delivery area!"] remoteExec ["hint", _caller];
					sleep 6;
					deleteVehicle _target;
					_veh = [_vehicle] remoteExec ["OA_fnc_spawnVehicle", 2];
					_veh setVehiclePosition [_position, [], 0, "NONE"];
					_veh setDir _direction;
				}, [_vehicle], 20, true, true, "", "true", 12];
			}] remoteExec["BIS_fnc_spawn"];
			
			_heli setSlingLoad _crate;
			_heli flyInHeight 30;

			private _wpDeliver = _group addWaypoint [_dropPos, 0];
			_wpDeliver setWaypointType "UNHOOK";
			_wpDeliver setWaypointSpeed "NORMAL";
			_wpDeliver setWaypointBehaviour "SAFE";
			_wpDelivery setWaypointCombatMode "BLUE";

			private _wpLeave = _group addWaypoint [_spawnPos, 1];
			_wpLeave setWaypointType "MOVE";
			_wpLeave setWaypointStatements ["true", "
				private _heli = vehicle this;
				{ deleteVehicle _x } forEach crew _heli;
				deleteVehicle _heli;
			"];
			
			_queue deleteAt 0;
			missionNameSpace setVariable ["OA_airport_delivery_jobs", _queue, true];
		};
		sleep 1;
	};
};
