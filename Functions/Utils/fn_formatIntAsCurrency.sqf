params ["_number"];

// this BIS_fnc_numberText function formats it as currency but using nbsp, so we have to replace them with comma
private _initialText = [_number] call BIS_fnc_numberText;
private _replacedText = (_initialText splitString " ") joinString ",";
private _formattedString = format ["$%1", _replacedText];

_formattedString
