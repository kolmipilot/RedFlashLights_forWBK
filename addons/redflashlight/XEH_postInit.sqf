#include "script_component.hpp"

// Exit on Server and Headless Client
if (!hasInterface) exitWith {};

[] spawn
{
    waitUntil { !isNull findDisplay 46 };
        sleep 0.9;
        player setVariable ["WBK_AttachedFlaslights",nil,true];
    ["WebKnight Headlamps", "wbk_headlampOnOff", ["Enable/Disable an headlamp", "Enable/Disable an headlamp"], { 
        _unit = missionNamespace getVariable["bis_fnc_moduleRemoteControl_unit", player];
        if ((lifeState _unit == "INCAPACITATED") or !(alive _unit)) exitWith {};
	if ((RED_WBK_HeadlampsAndFlashlights findIf {_x in items _unit}) == -1) exitWith {_unit spawn WBK_CustomFlashlight};
	_unit spawn RED_WBK_CustomFlashlight;
    }, {}, [38, [false, true, false]]] call cba_fnc_addKeybind;
};
