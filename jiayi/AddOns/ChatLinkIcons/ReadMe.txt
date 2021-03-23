ChatLinkIcons
by SDPhantom
https://www.wowinterface.com/forums/member.php?u=34145
https://www.curseforge.com/members/sdphantomgamer/projects
===============================================================================

All Rights Reserved - Use at your own risk
UnZip contents into the "Interface\AddOns" folder in your WoW instalation directory

===============================================================================
Versions:
v2.4 (2020-11-25)
	-Switched to using CreateAtlasMarkup() for Pawn's upgrade arrow

v2.3 (2020-10-14)
	-Shadowlands 9.0 Support
	-Fixed 9.0 race icons being scrambled
	-Workaround for missing GetAtlasInfo() in 9.0

v2.2 (2020-02-03)
	-Consolidated Classic and Modern versions into the same source code

v2.1 (2019-10-24)
	-BfA 8.3 PTR-ready
	-Fixed race icons being scrambled again (since 8.2.5)
	-Added Vulpera and Mechagnome races

v2.0 (2019-05-19)
	-Classic version available (uses UI-CharacterCreate-Races textures instead of CharacterCreateIcons)
	-Rewrote hook to use built-in MessageFilters
	-Support for CombatLog was dropped
	-Player links are now handled by hooking the link generators in ItemRef.lua
	-Fixed link color not resetting when the Pawn upgrade icon is shown

v1.7 (2019-04-28)
	-Fixed both "Draenei" racial icon pairs not showing
	-Link caching has been removed due to possible memory issues

v1.6 (2019-04-11)
	-BfA 8.1 Support
	-Icons added for the 8 Allied Races
	-Changed the Race/Gender initialization to make it easier to maintain
	-Fixed the Pawn upgrade icon corrupting item relinks

v1.5 (2017-02-03)
	-Pawn integration
	-Adds green upgrade arrow to the end of item links if it's an upgrade

v1.4 (2016-10-25)
	-Fixed 7.1 change to ScrollingMessageFrames

v1.3 (2016-06-14)
	-Legion Support
	-Added Demon Hunter icon and support for Wardrobe System links
	-Revamped link rewrite code
	-Fixed options panel refresh
	-Hidden anti-duplication signature no longer uses a blank texture

v1.2 (2012-07-01)
	-MoP Support
	-Added Pandaren race and Monk class icons
	-Fixed icon duplication when popping channels and whispers out into new window

v1.1 (2011-07-21)
	-Recoded options frame
	-Added the option to show/hide specific icons in player links
	-Fixed a glitch involving relinking copying textures in chat

v1.0 (2011-07-19)
	-Initial Version
