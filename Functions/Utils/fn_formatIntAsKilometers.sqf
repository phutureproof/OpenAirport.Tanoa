params ["_number"];

private _formattedString = format ["%1km", round(_number / 1000)];

_formattedString
