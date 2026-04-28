if (!isServer) exitWith {};

params ["_doReset"];

waitUntil { sleep 1; !isNil "OA_server_init_done" };

if (_doReset == 1) then {
	[] call OA_fnc_resetSave;
	OA_reset_from_params = true;
} else {
	OA_reset_from_params = false;
};
