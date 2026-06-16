#include "script_component.hpp"

class CfgPatches {
    class ADDON {
        name = COMPONENT_NAME;
        units[] = {"redflashlight_redflashlight_headlamplightobject_red", "redflashlight_redflashlight_headlamplightobject_red_weak"};
        weapons[] = {};
        requiredVersion = REQUIRED_VERSION;
        requiredAddons[] = {"redflashlight_main", "WBK_Headlamps"};
        author = "kolmipilot";
        authors[] = {"kolmipilot"};
        VERSION_CONFIG;
    };
};

#include "CfgEventHandlers.hpp"

class CfgWeapons
{
    class ItemCore;
	class InventoryItem_Base_F;
	class WBK_HeadLampItem: ItemCore {
		class ItemInfo: InventoryItem_Base_F {};
	};
    class GVAR(RedHeadLampItem): WBK_HeadLampItem
	{
		displayName="Red head lamp";
	};
	class GVAR(RedHeadLampItem_Weak): GVAR(RedHeadLampItem)
	{
		displayName="Red head lamp Weak";
	};
    class WBK_ShoulderLampItem_Weak: WBK_HeadLampItem {};
    class GVAR(RedShoulderLampItem): WBK_ShoulderLampItem_Weak
	{
		displayName="Red shoulder lamp";
	};
	class GVAR(RedShoulderLampItem_Weak): GVAR(RedShoulderLampItem)
	{
		displayName="Red shoulder lamp Weak";
	};
};

class CfgVehicles{
    class Reflector_Cone_01_narrow_orange_F;
    class GVAR(HeadLampLightObject_Red): Reflector_Cone_01_narrow_orange_F
	{
		scope=2;
		scopeCurator=2;
		displayName="Red head lamp";
		class Reflectors
		{
			class Light_1
			{
				color[]={0.5,0,0};
				ambient[]={0.5,0.1,0.1};
				intensity=200;
				size=1;
				innerAngle=60;
				outerAngle=118;
				coneFadeCoef=6;
				position="Light_1_pos";
				direction="Light_1_dir";
				hitpoint="Light_1_hitpoint";
				hitpointClass="Hit_Light_1";
				selection="Light_1_hide";
				useFlare=0;
				class Attenuation
				{
					start=0;
					constant=0;
					linear=2;
					quadratic=0.5;
					hardLimitStart=10;
					hardLimitEnd=20;
				};
			};
			class Light_1_Flare: Light_1
			{
				hitpointClass="Hit_Light_1_Flare";
				outerAngle=178;
				useFlare=0;
				flareSize=0;
				flareMaxDistance=1;
			};
		};
	};
	class GVAR(HeadLampLightObject_Red_Weak): GVAR(HeadLampLightObject_Red)
	{
		scope=2;
		scopeCurator=2;
		displayName="Red head lamp";
		class Reflectors
		{
			class Light_1
			{
				color[]={0.5,0,0};
				ambient[]={0.5,0.1,0.1};
				intensity=100;
				size=1;
				innerAngle=60;
				outerAngle=118;
				coneFadeCoef=6;
				position="Light_1_pos";
				direction="Light_1_dir";
				hitpoint="Light_1_hitpoint";
				hitpointClass="Hit_Light_1";
				selection="Light_1_hide";
				useFlare=0;
				class Attenuation
				{
					start = 0;
					constant = 0;
					linear = 4;
					quadratic = 2;
					hardLimitStart = 3;
					hardLimitEnd = 6;
				};
			};
			class Light_1_Flare: Light_1
			{
				hitpointClass="Hit_Light_1_Flare";
				outerAngle=178;
				useFlare=0;
				flareSize=0;
				flareMaxDistance=1;
			};
		};
	};
};
