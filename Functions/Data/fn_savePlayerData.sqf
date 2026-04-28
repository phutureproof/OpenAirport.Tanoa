if (!isServer) exitWith {};

["Gathering player data"] call OA_fnc_sendGlobalMsg;
_savedPlayerData = [];

{
	_uid = getPlayerUID _x;
	_uniform = uniform _x;
	_vest = vest _x;
	_backpack = backpack _x;
	_headgear = headgear _x;
	_goggles = goggles _x;
	_assignedItems = assignedItems _x;
	_uniformItems = uniformItems _x;
	_vestItems = vestItems _x;
	_backpackItems = backpackItems _x;
	_weapons = weaponsItems _x;
	_hasQuad = _x getVariable ["OA_transport_quad", false];
	_money = _x getVariable ["OA_player_money", 0];

	_savedPlayerData pushBack [
		_uid,
		[
			_uniform, _vest, _backpack, _headgear, _goggles,
			_assignedItems, _uniformItems, _vestItems, _backpackItems, _weapons, _hasQuad, _money
		]
	];
} foreach allPlayers;

profileNamespace setVariable ["OA_player_data", _savedPlayerData];
saveProfileNamespace;

["Player data stored"] call OA_fnc_sendGlobalMsg;
