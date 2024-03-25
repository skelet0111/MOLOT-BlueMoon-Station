//The base for clockwork mobs
/mob/living/simple_animal/hostile/clockwork
	faction = list("neutral", "ratvar")
	gender = NEUTER
	icon = 'icons/mob/clockwork_mobs.dmi'
	unique_name = 1
	minbodytemp = 0
	unsuitable_atmos_damage = 0
	atmos_requirements = list("min_oxy" = 0, "max_oxy" = 0, "min_tox" = 0, "max_tox" = 0, "min_co2" = 0, "max_co2" = 0, "min_n2" = 0, "max_n2" = 0) //Robotic
	damage_coeff = list(BRUTE = 1, BURN = 1, TOX = 0, CLONE = 0, STAMINA = 0, OXY = 0)
	healable = FALSE
	del_on_death = TRUE
	speak_emote = list("clanks", "clinks", "clunks", "clangs")
	verb_ask = "requests"
	verb_exclaim = "proclaims"
	verb_whisper = "imparts"
	verb_yell = "harangues"
	initial_language_holder = /datum/language_holder/clockmob
	bubble_icon = "clock"
	light_color = "#E42742"
	death_sound = 'sound/magic/clockwork/anima_fragment_death.ogg'
	speech_span = SPAN_ROBOT
	var/playstyle_string = "<span class='heavy_brass'>You are a bug, yell at whoever spawned you!</span>"
	var/empower_string = "<span class='heavy_brass'>You have nothing to empower, yell at the coders!</span>" //Shown to the mob when the herald beacon activates
	typing_indicator_state = /obj/effect/overlay/typing_indicator/additional/clock

/mob/living/simple_animal/hostile/clockwork/Initialize(mapload)
	. = ..()
	update_values()

/mob/living/simple_animal/hostile/clockwork/Login()
	..()
	add_servant_of_ratvar(src, TRUE)
	to_chat(src, playstyle_string)
	if(GLOB.ratvar_approaches)
		to_chat(src, empower_string)

/mob/living/simple_animal/hostile/clockwork/ratvar_act()
	fully_heal(TRUE)

/mob/living/simple_animal/hostile/clockwork/electrocute_act(shock_damage, source, siemens_coeff = 1, flags = NONE)
	return 0 //ouch, my metal-unlikely-to-be-damaged-by-electricity-body

/mob/living/simple_animal/hostile/clockwork/examine(mob/user)
	var/t_He = ru_who(TRUE)
	var/t_s = p_s()
	var/msg = "<span class='brass'>This is [icon2html(src, user)] \a <b>[src]</b>!\n"
	if(desc)
		msg += "<hr>[desc]\n"
	if(health < maxHealth)
		msg += "<hr><span class='warning'>"
		if(health >= maxHealth/2)
			msg += "[t_He] look[t_s] slightly dented.\n"
		else
			msg += "<b>[t_He] look[t_s] severely dented!</b>\n"
		msg += "</span>"
	var/addendum = examine_info()
	if(addendum)
		msg += "<hr>[addendum]\n"
	msg += "</span>"

	return list(msg)

/mob/living/simple_animal/hostile/clockwork/proc/examine_info() //Override this on a by-mob basis to have unique examine info
	return

/mob/living/simple_animal/hostile/clockwork/proc/update_values() //This is called by certain things to check GLOB.ratvar_awakens and GLOB.ratvar_approaches

/mob/living/simple_animal/hostile/clockwork/clocktank
	name = "Clockwork Mini-Tank"
	desc = "Small as a cat, as powerful as the real deal."
	icon = 'modular_splurt/icons/mobs/vharmob.dmi'
	icon_state = "tankclock"
	icon_living = "tankclock"
	icon_dead = "idle"
	gender = NEUTER
	speak_chance = 0
	turns_per_move = 2
	turns_per_move = 3
	maxHealth = 200
	health = 200
	see_in_dark = 7
	response_help_continuous  = "pets"
	response_disarm_continuous = "pushes aside"
	response_harm_continuous   = "shoots"
	melee_damage_lower = 15
	melee_damage_upper = 20
	armour_penetration = 10
	attack_verb_continuous = "shoots"
	projectilesound = 'sound/weapons/emitter.ogg'
	faction = list("ratvar")
	ranged = 1
	rapid = 2
	rapid_fire_delay = 10
	retreat_distance = 1
	minimum_distance = 3
	projectiletype = /obj/item/projectile/beam/clockworkbeam
	harm_intent_damage = 5
	obj_damage = 30
	a_intent = INTENT_HARM
	death_sound = 'sound/machines/buzz-two.ogg'
	deathmessage = "beeps violently and explodes..."
	move_to_delay = 4
	loot = list(/obj/effect/gibspawner/robot)

/mob/living/simple_animal/hostile/clockwork/clocktank/weak
	name = "Weakened Clockwork Mini-Tank"
	desc = "Even weaker variants of the mini-tank, don't get cocky tho."
	maxHealth = 30
	health = 30

/mob/living/simple_animal/hostile/boss/clockcultistboss
	name = "Clockwork Mechanic"
	desc = "This one seems to be wielding some kind of clock and a brass wrench, what a chad."
	icon = 'modular_splurt/icons/mobs/vharmob.dmi'
	icon_state = "clockboss"
	icon_living = "clockboss"
	icon_dead = "idle"
	boss_abilities = list(/datum/action/boss/clockie_summon_minions)
	point_regen_amount = 3
	gender = NEUTER
	speak_chance = 0
	turns_per_move = 2
	maxHealth = 700
	health = 700
	see_in_dark = 7
	response_help_continuous  = "pets"
	response_disarm_continuous = "pushes aside"
	response_harm_continuous   = "bonks"
	melee_damage_lower = 2
	melee_damage_upper = 5
	armour_penetration = 5
	attack_verb_continuous = "bonks"
	attack_sound = 'modular_splurt/sound/misc/bonk.ogg'
	faction = list("ratvar")
	ranged = 0
	retreat_distance = 3
	minimum_distance = 7
	harm_intent_damage = 5
	obj_damage = 60
	a_intent = INTENT_HARM
	death_sound = 'sound/voice/ed209_20sec.ogg'
	deathmessage = "lets out scream and explodes in a pile of gibs..."
	move_to_delay = 4
	loot = list(/obj/effect/gibspawner/human)

/datum/action/boss/clockie_summon_minions
	name = "Summon Minions"
	icon_icon = 'icons/mob/actions/actions_minor_antag.dmi'
	button_icon_state = "art_summon"
	usage_probability = 90
	boss_cost = 20
	boss_type = /mob/living/simple_animal/hostile/boss/clockcultistboss
	needs_target = FALSE
	req_statuses = list(AI_ON)
	say_when_triggered = "FOR RAT'VAR!"
	var/list/summoned_minions = list()
	var/maximum_tanks = 4
	var/tanks_to_summon = 2

/datum/action/boss/clockie_summon_minions/Trigger()
	. =..()
	if(!.)
		return
	var/to_summon = tanks_to_summon
	var/current_len = length(summoned_minions)
	if(current_len > maximum_tanks - tanks_to_summon)
		for(var/a in (maximum_tanks - tanks_to_summon) to current_len)
			var/mob/living/simple_animal/hostile/clockwork/clocktank/weak/S = popleft(summoned_minions)
			if(!S.client)
				qdel(S)
			else
				S.forceMove(boss.drop_location())
				S.revive(TRUE)
				summoned_minions += S
				to_summon--

	var/static/list/minions = list(
	/mob/living/simple_animal/hostile/clockwork/clocktank/weak)

	var/list/directions = GLOB.cardinals.Copy()
	for(var/i in 1 to to_summon)
		var/minions_chosen = pick(minions)
		var/mob/living/simple_animal/hostile/clockwork/clocktank/weak/S = new minions_chosen (get_step(boss,pick_n_take(directions)), 1)
		S.faction = boss.faction
		RegisterSignal(S, COMSIG_PARENT_QDELETING, .proc/remove_from_list)
		summoned_minions += S

/datum/action/boss/clockie_summon_minions/proc/remove_from_list(datum/source, forced)
	summoned_minions -= source

/mob/living/simple_animal/hostile/clockcultistmelee
	name = "Clockwork Cultist"
	desc = "The clock is ticking."
	icon = 'modular_splurt/icons/mobs/vharmob.dmi'
	icon_state = "clockworknight"
	icon_living = "clockworknight"
	icon_dead = "idle"
	gender = NEUTER
	speak_chance = 0
	turns_per_move = 2
	turns_per_move = 3
	maxHealth = 200
	health = 200
	see_in_dark = 7
	response_help_continuous  = "pets"
	response_disarm_continuous = "pushes aside"
	response_harm_continuous   = "thrusts"
	melee_damage_lower = 20
	melee_damage_upper = 40
	armour_penetration = 10
	attack_verb_continuous = "thrusts"
	attack_sound = 'sound/weapons/blade1.ogg'
	faction = list("ratvar")
	ranged = 0
	harm_intent_damage = 5
	obj_damage = 60
	a_intent = INTENT_HARM
	death_sound = 'sound/voice/ed209_20sec.ogg'
	deathmessage = "lets out scream and explodes in a pile of gibs..."
	move_to_delay = 4
	loot = list(/obj/effect/gibspawner/human)

/mob/living/simple_animal/hostile/clockcultistranged
	name = "Clockwork Cultist"
	desc = "The clock is ticking."
	icon = 'modular_splurt/icons/mobs/vharmob.dmi'
	icon_state = "clockworkmage"
	icon_living = "clockworkmage"
	icon_dead = "idle"
	gender = NEUTER
	speak_chance = 0
	turns_per_move = 2
	turns_per_move = 3
	maxHealth = 100
	health = 100
	see_in_dark = 7
	response_help_continuous  = "pets"
	response_disarm_continuous = "pushes aside"
	response_harm_continuous   = "casts"
	melee_damage_lower = 20
	melee_damage_upper = 40
	armour_penetration = 10
	attack_verb_continuous = "casts"
	projectilesound = 'sound/weapons/emitter.ogg'
	faction = list("ratvar")
	ranged = 1
	rapid = 2
	rapid_fire_delay = 6
	retreat_distance = 1
	minimum_distance = 3
	projectiletype = /obj/item/projectile/beam/clockworkbeam
	harm_intent_damage = 5
	obj_damage = 60
	a_intent = INTENT_HARM
	death_sound = 'sound/voice/ed209_20sec.ogg'
	deathmessage = "lets out scream and explodes in a pile of gibs..."
	move_to_delay = 4
	loot = list(/obj/effect/gibspawner/human)
