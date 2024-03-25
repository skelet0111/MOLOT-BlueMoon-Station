// //Marauder armor, used to create clockwork marauders - sturdy frontline combatants that can deflect projectiles.
// /obj/item/clockwork/construct_chassis/clocktank
// 	name = "Clocktank Chassis"
// 	desc = "A pile of sleek and well-polished brass armor. A two small red gemstone sits in its faceplate."
// 	icon_state = "smashed_anime_fragment"
// 	construct_name = "clockwork tahk"
// 	construct_desc = "<span class='neovgre_small'>It will become a <b>clocktank,</b> a well-rounded frontline combatant that can fire his gun.</span>"
// 	creation_message = "<span class='neovgre_small bold'>Crimson fire begins to rage in the armor as it rises into the air with its armaments!</span>"
// 	construct_type = /mob/living/simple_animal/hostile/clockwork/clocktank

// /obj/item/station_clock_curse
// 	name = "Проклятая Сфера"
// 	desc = "Эта сфера хранит в себе первородное зло и, наверное, это недопустимо ронять или даже ломать..."
// 	icon = 'icons/effects/clockwork_effects.dmi'
// 	icon_state ="ratvars_flame"
// 	var/static/curselimit = 0

// /obj/item/station_clock_curse/attack_self(mob/living/user)
// 	if(!is_servant_of_ratvar(user, TRUE))
// 		user.dropItemToGround(src, TRUE)
// 		user.DefaultCombatKnockdown(100)
// 		to_chat(user, "<span class='warning'>Мощная сила отталкивает вас от [src]!</span>")
// 		return
// 	if(curselimit >= 1)
// 		to_chat(user, "<span class='notice'>Мы исчерпали свою способность проклинать Космическую Станцию.</span>")
// 		return
// 	if(locate(/obj/structure/destructible/clockwork/massive/ratvar) in GLOB.poi_list)
// 		to_chat(user, "<span class='warning'>Ratvar is already on this plane, there is no delaying the end of all things.</span>")
// 		return

// 	to_chat(user, "<span class='danger'>Вы разбиваете сферу! Бронзовая сущность поднимается в воздух, затем исчезает.</span>")
// 	playsound(user.loc, 'sound/effects/glassbr1.ogg', 50, 1)
// 	qdel(src)
// 	sleep(pick(100, 200, 400, 800, 1200))
// 	var/datum/round_event_control/portal_storm_clock/portal_storm_clock = new/datum/round_event_control/portal_storm_clock
// 	portal_storm_clock.runEvent()
// 	curselimit++
