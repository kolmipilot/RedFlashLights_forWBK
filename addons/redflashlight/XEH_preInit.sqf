#include "script_component.hpp"

ADDON = false;

PREP_RECOMPILE_START;
#include "XEH_PREP.hpp"
PREP_RECOMPILE_END;

ADDON = true;

RED_WBK_HeadlampsAndFlashlights = [QGVAR(RedHeadLampItem), QGVAR(RedShoulderLampItem)];


["WebKnight Headlamps", "wbk_headlampOnOff", ["Enable/Disable an headlamp", "Enable/Disable an headlamp"], { 
	_unit = missionNamespace getVariable["bis_fnc_moduleRemoteControl_unit", player];
    if ((lifeState _unit == "INCAPACITATED") or !(alive _unit)) exitWith {};
	if ((RED_WBK_HeadlampsAndFlashlights findIf {_x in items _unit}) == -1) exitWith {_unit spawn WBK_CustomFlashlight};
	_unit spawn RED_WBK_CustomFlashlight;
}, {}, [38, [false, true, false]]] call cba_fnc_addKeybind;  

RED_WBK_ForceFlashlightOff = {
	waitUntil {!(alive _this) or !(isNull objectParent _this) or (isNil {_this getVariable "WBK_AttachedFlaslights"}) or (RED_WBK_HeadlampsAndFlashlights findIf {_x in items _this} == -1)};
	if (!(isNil {_this getVariable "WBK_AttachedFlaslights"})) exitWith {
		{
			deleteVehicle _x;
		} forEach (_this getVariable "WBK_AttachedFlaslights");
		_this setVariable ["WBK_AttachedFlaslights",nil,true]; 
	};
};


RED_WBK_CustomFlashlight = {
	_unit = _this;
	_hasRed = ((QGVAR(RedHeadLampItem) in items _unit) || (QGVAR(RedShoulderLampItem) in items _unit));
	if (!_hasRed) exitWith { _unit spawn WBK_CustomFlashlight };
	if (!(isNil {_unit getVariable "WBK_AttachedFlaslights"})) exitWith {
		_unit playActionNow "WBK_head_flashlight_off";
		[_unit, "\WBK_Headlamps\headlamp_off.wav"] spawn WBK_FLASHLIGHT_PlaySound;
		{
			deleteVehicle _x;
		} forEach (_unit getVariable "WBK_AttachedFlaslights");
		_unit setVariable ["WBK_AttachedFlaslights", nil, true];
	};
    switch (true) do {
    case (QGVAR(RedShoulderLampItem) in items _unit): {
    // create a simple red shoulderlamp (minimal, non-invasive)
	[_unit, "\WBK_Headlamps\gunlight_on.wav"] spawn WBK_FLASHLIGHT_PlaySound;
	_unit playActionNow "WBK_head_flashlight";
	_light = QGVAR(HeadLampLightObject_Red) createVehicle [0,0,0];
	_vol = createSimpleObject [QGVAR(HeadLampLightObject_Red), getPosASL _unit];
	_light attachTo [_unit,[0,0.041,0.22], "head", true];
	_vol attachTo [_unit,[0,-0.01,0.2], "head", true];
	_unit setVariable ["WBK_AttachedFlaslights", [_vol, _light], true];
    [[_vol,_light], { 
			_y = 0;      
			_p = 185;      
			_r  = 80;     
			(_this select 0) setVectorDirAndUp [            
			 [sin _y * cos _p, cos _y * cos _p, sin _p],            
			 [[sin _r, -sin _p, cos _r * cos _p], -_y] call BIS_fnc_rotateVector2D            
			];   
			_y = -2;      
			_p = 0;      
			_r  = 0;     
			(_this select 1) setVectorDirAndUp [            
			 [sin _y * cos _p, cos _y * cos _p, sin _p],            
			 [[sin _r, -sin _p, cos _r * cos _p], -_y] call BIS_fnc_rotateVector2D            
			]; 
			}] remoteExec ["call",0];
	_unit spawn RED_WBK_ForceFlashlightOff;
    };
    case (QGVAR(RedHeadLampItem) in items _unit): {
	// create a simple red headlamp (minimal, non-invasive)
	[_unit, "\WBK_Headlamps\headlamp_on.wav"] spawn WBK_FLASHLIGHT_PlaySound;
	_unit playActionNow "WBK_head_flashlight";
	_light = QGVAR(HeadLampLightObject_Red) createVehicle [0,0,0];
	_vol = createSimpleObject [QGVAR(HeadLampLightObject_Red), getPosASL _unit];
	_light attachTo [_unit,[0,0.041,0.22], "head", true];
	_vol attachTo [_unit,[0,-0.01,0.2], "head", true];
	_unit setVariable ["WBK_AttachedFlaslights", [_vol, _light], true];
    [[_vol,_light], { 
			_y = -8;   
			_p = 190;   
			_r  = 80;  
			(_this select 0) setVectorDirAndUp [         
			[sin _y * cos _p, cos _y * cos _p, sin _p],         
			[[sin _r, -sin _p, cos _r * cos _p], -_y] call BIS_fnc_rotateVector2D         
			];
			_y = -5;   
			_p = 10;   
			_r  = 0;  
			(_this select 1) setVectorDirAndUp [         
			[sin _y * cos _p, cos _y * cos _p, sin _p],         
		    [[sin _r, -sin _p, cos _r * cos _p], -_y] call BIS_fnc_rotateVector2D         
			];  
			}] remoteExec ["call",0];
	_unit spawn RED_WBK_ForceFlashlightOff;
    };
    };
};
