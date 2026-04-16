params ["_obj"];

_list = [
	["C_Heli_Light_01_civil_F", "M-900", 50000],
	["B_Heli_Light_01_F", "MH-9 Hummingbird", 100000],
	["B_Heli_Transport_01_F", "UH-80 Ghost Hawk", 250000],
	["B_Heli_Transport_01_camo_F", "UH-80 Ghost Hawk (Camo)", 250000],
	["B_Heli_Transport_03_unarmed_F", "CH-67 (Black)", 1500000],
	["O_Heli_Light_02_unarmed_F", "PO-30 Orca", 200000],
	["O_Heli_Transport_04_bench_F", "Mi-290 Taru (Bench)", 175000],
	["O_Heli_Transport_04_covered_F", "Mi-290 Taru (Covered)", 345000],
	["I_Heli_light_03_unarmed_F", "WY-55 Hellcat (Unarmed)", 175000],
	["I_Heli_Transport_02_F", "CH-49 Mohawk", 345000]
];

/*
_obj addAction [
	"<t color='#189979'>Buy First Aid Kit ($500.00)</t>",
	{
		params ["_target", "_caller", "_actionId", "_args"];
		private _funds = missionNamespace getVariable ["OA_airport_funds", 0];
		if (_funds < 500) then {
			hint "You don't have enough to purchase a first aid kit";
		};
		[-500] remoteExec ["OA_fnc_updateFunds", 2];
		_caller addItem "FirstAidKit";
	}, _x, 30, true, false, "", "true", 5
];
*/

{
	_class = _x select 0;
	_name = _x select 1;
	_price = _x select 2;

	_obj addAction [format ["<t color='#189979'>Buy %1 (%2)</t>", _name, [_price] call OA_fnc_formatIntAsCurrency],
		{
			params ["_target", "_caller", "_actionId", "_args"];
			_class = _args select 0;
			_name = _args select 1;
			_price = _args select 2;
			if (missionNamespace getVariable ["OA_airport_funds", 0] < _price) exitWith {
				hint "Not enough money to buy vehicle";
			};
			[_caller, _class] remoteExec ["OA_fnc_spawnVehicle", 2];
			[_price * -1] remoteExec ["OA_fnc_updateFunds", 2];
			[format ["%1 has purchased a %2 for %3", name _caller, _name, [_price] call OA_fnc_formatIntAsCurrency]] call OA_fnc_sendATCMsg;
		}, _x, 30, true, true, "", "true", 5
	];
} forEach _list;

_obj addAction ["================", {}, [], 30, true, true, "", "true", 5];
