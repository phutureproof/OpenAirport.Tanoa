if (!isServer) exitWith {};

params ["_player"];

waitUntil {
	sleep 1;
	!isNil "OA_reset_from_params" && !isNil "OA_player_starting_balance_from_params"
};

_allPlayerData = profileNamespace getVariable ["OA_player_data", []];
_uid = getPlayerUID _player;
_playerData = [];

{
	_playerUID = _x select 0;
	_playerInv = _x select 1;

	if (_uid == _playerUID) exitWith {
		_playerData = _playerInv;
	};
} forEach _allPlayerData;

if (count _playerData == 0) exitWith {
	_startingBalance = missionNamespace getVariable ["OA_player_starting_balance", 0];
	_player setVariable ["OA_player_money", _money, true];
	_msg = format ["Welcome to the server %1, please check the briefing screen for game mode information.", name _player];
	[_msg] call OA_fnc_sendGlobalMsg;
};

_msg = format ["Welcome back %1! Enjoy your stay with us. Don't forget to check the briefing screen for game mode information.", name _player];
[_msg] call OA_fnc_sendGlobalMsg;

[[_playerData], {
	params ["_playerData"];
	
	// deconstruct data array
	_playerData params [
		["_uniform", ""],
		["_vest", ""],
		["_backpack", ""],
		["_headgear", ""],
		["_goggles", ""],
		["_assignedItems", []],
		["_uniformItems", []],
		["_vestItems", []],
		["_backpackItems", []],
		["_weapons", []],
		["_hasQuad", false],
		["_money", 0]
	];

	// quad is a special case
	if(_hasQuad) then { player setVariable ["OA_transport_quad", true, true]; };

	// money is a special case 
	player setVariable ["OA_player_money", _money, true];

	// remove all items from player
	removeAllWeapons player;
	removeAllItems player;
	removeAllAssignedItems player;
	removeUniform player;
	removeVest player;
	removeBackpack player;
	removeHeadgear player;
	removeGoggles player;

	// add clothing
	if (_uniform isNotEqualTo "") then { player forceAddUniform _uniform; };
	if (_vest isNotEqualTo "") then { player addVest _vest; };
	if (_backpack isNotEqualTo "") then { player addBackpack _backpack; };
	if (_headgear isNotEqualTo "") then { player addHeadgear _headgear; };
	if (_goggles isNotEqualTo "") then { player addGoggles _goggles; };

	// add items to their respective container
	{ player addItemToUniform _x; } forEach _uniformItems;
	{ player addItemToVest _x; } forEach _vestItems;
	{ player addItemToBackpack _x; } forEach _backpackItems;

	// assigned items 
	{ player linkItem _x; } forEach _assignedItems;

	// if player has radio add them to atc channel
	if ("ItemRadio" in (items player + assignedItems player)) then {
		_atcChannel = missionNamespace getVariable ["OA_ATCRadioChannelID", 0];
		_atcChannel radioChannelAdd [player];
	};

	// default items
	player linkItem "ItemWatch";
	player linkItem "ItemCompass";
	player linkItem "ItemMap";

	// weapons 
	{
		_x params [
			["_weaponClass", ""],
			["_muzzle", ""],
			["_pointer", ""],
			["_optic", ""],
			["_primaryMag", ""],
			["_secondaryMag", ""],
			["_bipod", ""]
		];
		
		if (_weaponClass isNotEqualTo "") then {
			player addWeapon _weaponClass;
			
			if (_muzzle isNotEqualTo "") then { player addPrimaryWeaponItem _muzzle; };
			if (_pointer isNotEqualTo "") then { player addPrimaryWeaponItem _pointer; };
			if (_optic isNotEqualTo "") then { player addPrimaryWeaponItem _optic; };
			if (_bipod isNotEqualTo "") then { player addPrimaryWeaponItem _bipod; };
			
			if (count _primaryMag > 0) then { player addMagazine _primaryMag; };
			if (count _secondaryMag > 0) then { player addMagazine _secondaryMag; };
		};
	} forEach _weapons;
}] remoteExec["spawn", owner _player];
