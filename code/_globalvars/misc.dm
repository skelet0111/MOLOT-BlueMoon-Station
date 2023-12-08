GLOBAL_VAR_INIT(admin_notice, "") // Admin notice that all clients see when joining the server

GLOBAL_VAR_INIT(timezoneOffset, 0) // The difference betwen midnight (of the host computer) and 0 world.ticks.

GLOBAL_VAR_INIT(year, time2text(world.realtime,"YYYY"))
GLOBAL_VAR_INIT(year_integer, text2num(year)) // = 2013???

/// In-universe, SS13 is set 540 years in the future from the real-world day, hence this number for determining the year-offset for the in-game year.
#define STATION_YEAR_OFFSET 540

/// Define that just has the current in-universe year for use in whatever context you might want to display that in. (For example, 2022 -> 2562 given a 540 year offset)
#define CURRENT_STATION_YEAR (GLOB.year_integer + STATION_YEAR_OFFSET)

	// For FTP requests. (i.e. downloading runtime logs.)
	// However it'd be ok to use for accessing attack logs and such too, which are even laggier.
GLOBAL_VAR_INIT(fileaccess_timer, 0)

GLOBAL_DATUM_INIT(data_core, /datum/datacore, new)

GLOBAL_VAR_INIT(CELLRATE, 0.002)  // conversion ratio between a watt-tick and kilojoule, dimensionless, kilojoules/watt-tick
GLOBAL_VAR_INIT(CHARGELEVEL, 0.001) // Cap for how fast cells charge, as a percentage-per-tick (.001 means cellcharge is capped to 1% per second)

GLOBAL_LIST_EMPTY(powernets)

GLOBAL_VAR_INIT(bsa_unlock, FALSE)	//BSA unlocked by head ID swipes

GLOBAL_LIST_EMPTY(player_details)	// ckey -> /datum/player_details

GLOBAL_LIST_EMPTY(clientless_round_timeouts)	// ckey -> time that ckey can rejoin round

// All religion stuff
GLOBAL_VAR(religion)
GLOBAL_VAR(deity)
GLOBAL_VAR(bible_name)
GLOBAL_VAR(bible_icon_state)
GLOBAL_VAR(bible_item_state)
GLOBAL_VAR(holy_weapon_type)
GLOBAL_VAR(holy_armor_type)

GLOBAL_VAR_INIT(internal_tick_usage, 0.2 * world.tick_lag)
