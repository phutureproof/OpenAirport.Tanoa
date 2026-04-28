private _listData = [
    ["Helmet ($15,000)", "helmet-15000-a new helmet"],
    ["Uniform ($10,000)", "uniform-10000-a new uniform"],
    ["Radio ($5,000)", "radio-5000-a new radio"],
    ["GPS ($5,000)", "gps-5000-a new GPS"],
    ["Transportation Quad ($10,000)", "quad-10000-a transportation quad"],
    ["Night Vision Goggles ($5,000)", "nvgoggles-5000-a new set of NVG's"],
    ["Backpack ($1,000)", "backpack-1000-a new backpack"],
    ["First Aid Kit ($500)", "firstaidkit-500-a first aid kit"],
    ["First Aid Kit x5 ($2,500)", "firstaidkitx5-2500-5 First Aid Kits"]
];

private _buttonText = 'Purchase Item';

private _buttonHandler = {
    params ["_itemName", "_itemData"];
    
    _objParams = (_itemData splitString "-");
    _objType = (_objParams select 0);
    _objPrice = parseNumber (_objParams select 1);
    _objName = (_objParams select 2);

    _currentFunds = player getVariable ["OA_player_money", 0];

    if (_currentFunds < _objPrice) exitWith {
        hint "Not enough money to buy item";
    };

    _doPurchase = false;

    switch (_objType) do {
        case "helmet": {
            _type = (selectRandom ["H_PilotHelmetHeli_I_E", "H_PilotHelmetFighter_I_E", "H_PilotHelmetHeli_I", "H_PilotHelmetHeli_O", "H_PilotHelmetHeli_B"]);
            removeHeadgear player;
            player addHeadgear _type;
            _doPurchase = true;
        };
        case "uniform": {
            _type = (selectRandom ["U_I_HeliPilotCoveralls", "U_I_E_Uniform_01_coveralls_F", "U_B_HeliPilotCoveralls"]);
            removeUniform player;
            player forceAddUniform _type;
            _doPurchase = true;
        };
        case "backpack": {
            _type = (selectRandom ["B_TacticalPack_ocamo", "B_TacticalPack_blk", "B_TacticalPack_rgr", "B_TacticalPack_mcamo", "B_TacticalPack_oli"]);
            removeBackpack player;
            player addBackpack _type;
            _doPurchase = true;
        };
        case "gps": {
            _type = "ItemGPS";
            if (_type in (items player + assignedItems player)) exitWith {
                hint "You already own a GPS";
            };
            player linkItem _type;
            _doPurchase = true;
        };
        case "radio": {
            _type = "ItemRadio";
            if (_type in (items player + assignedItems player)) exitWith {
                hint "You already own a radio";
            };
            player linkItem _type;
            _atcChannel = missionNamespace getVariable ["OA_ATCRadioChannelID", 0];
            _atcChannel radioChannelAdd [player];
            [_atcChannel] remoteExec ["setCurrentChannel", owner player];
            _doPurchase = true;
        };
        case "nvgoggles": {
            _type = (selectRandom ["NVGoggles_OPFOR", "NVGoggles", "NVGoggles_INDEP", "NVGoggles_tna_F"]);
            player linkItem _type;
            _doPurchase = true;
        };
        case "firstaidkit": {
            player addItem "FirstAidKit";
            _doPurchase = true;
        };
        case "firstaidkitx5": {
            for "_i" from 1 to 5 do { player addItem "FirstAidKit"; };
            _doPurchase = true;
        };
        case "quad": {
            _ownsQuad = player getVariable["OA_transport_quad", false];
            if (_ownsQuad) exitWith {
                hint "You already own the transport quad";
            };
            player setVariable ["OA_transport_quad", true];
            _doPurchase = true;
        };
    };

    // handle price and show messages
    if (_doPurchase) then {
        [player, (-1 * _objPrice)] remoteExec ["OA_fnc_updatePlayerFunds", 2];
        _atcMsg = format [
            "%1 spent %2 on %3",
            name player,
            [_objPrice] call OA_fnc_formatIntAsCurrency,
            _objName
        ];
        [_atcMsg] call OA_fnc_sendATCMsg;
    };
};

[_listData, _buttonText, _buttonHandler] call OA_fnc_genericListGUI;
