# Gemesis
Mod for Don't Starve (Together) to craft and split gems to/from their constituent colors.

**Compatible with Don't Starve Together, and all versions of Don't Starve, i. e. Shipwrecked, Hamlet, and Reign of Giants.**

## Usage

Refine green and orange gems by combining their respective primary color gems,
just like purple gems. Cast the deconstructor staff on purple, green and orange
gems to split them back into their primary colors.

New recipes (Prestihatitator / Shadow Manipulator):
- 1 Red Gem  + 1 Yellow Gem -> Orange Gem
- 1 Blue Gem + 1 Yellow Gem -> Green Gem

Deconstructor Staff:
- Purple Gem -> 1 Red Gem  + 1 Blue Gem
- Orange Gem -> 1 Red Gem  + 1 Yellow Gem
- Green Gem  -> 1 Blue Gem + 1 Yellow Gem

Please note that this mod does _not_ add crafting recipes for gems, you'll still need to farm for gems! However, this mod takes a bit of tedium out of farming for specific "high tier" colors of gems, as you can now combine two low-tier, farmable gems into green and orange gems, and split up the higher tier gems for recombination if you happen to have a surplus of a specific color. No extra cost except for deconstructor staff charges are incurred. In my humble opinion, this mod doesn't affect balancing as much as most other gem crafting mods, and stays very close to the vanilla feeling while still removing the tedious gem farming bits.

## Installation

### Steam
If you are running the Steam version of the game, install the most recent version of this mod by subscribing to it on the Steam Workshop, and it will automatically be available in game on the next start. Steam will also automatically take care of updating the mod if a newer version is released. Make sure to enable the mod if you want to use it. :)

[Steam Workshop page for Don't Starve](https://steamcommunity.com/sharedfiles/filedetails/?id=2556583772)

[Steam Workshop page for Don't Starve Together](https://steamcommunity.com/sharedfiles/filedetails/?id=2556417192)

### GOG.com or other standalone version

If you're running a standalone version of Don't Starve, you can download a release from Github or from the Klei Game Modifications download page, and extract it into the `mods` directory of Don't Starve. Please refer to the [instructions in the official Klei forum](https://forums.kleientertainment.com/forums/topic/29658-how-to-install-a-mod-from-the-klei-downloads-page/) on how to install a mod manually.

### Dedicated Server

Proper installation of mods on dedicated servers is a bit more involved, but in general it's enough to edit the file `dedicated_server_mods_setup.lua` in the `mods` directory of the dedicated server installation, and add `ServerModSetup("2556417192")` to it. The mod's Steam Workshop ID is `2556417192`.
