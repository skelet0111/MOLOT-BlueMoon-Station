GLOBAL_LIST_EMPTY(all_clockers)

/proc/is_eligible_servant(mob/M)
	if(!istype(M))
		return FALSE
	if(M.mind)
		if(M.mind.assigned_role in list("Captain", "Chaplain"))
			return FALSE
		if(M.mind.enslaved_to && !is_servant_of_ratvar(M.mind.enslaved_to))
			return FALSE
		if(M.mind.unconvertable)
			return FALSE
	else
		return FALSE
	if(iscultist(M) || isconstruct(M) || ispAI(M))
		return FALSE
	if(isliving(M))
		var/mob/living/L = M
		if(HAS_TRAIT(L, TRAIT_MINDSHIELD))
			return FALSE
	if(ishuman(M) || isbrain(M) || isguardian(M) || issilicon(M) || isclockmob(M) || istype(M, /mob/living/simple_animal/drone/cogscarab)
		return TRUE
	return FALSE

/datum/antagonist/clockcult
	name = "Clock Cultist"
	roundend_category = "clock cultists"
	antagpanel_category = "Clockcult"
	job_rank = ROLE_SERVANT_OF_RATVAR
	antag_moodlet = /datum/mood_event/cult
	skill_modifiers = list(/datum/skill_modifier/job/level/wiring, /datum/skill_modifier/job/level/dwarfy/blacksmithing)
	ui_name = "AntagInfoClockwork"
	threat = 3
	var/datum/team/clockcult/clock_team
	var/make_team = TRUE //This should be only false for tutorial scarabs
	var/neutered = FALSE			//can not use round ending, gibbing, converting, or similar things with unmatched round impact
	var/ignore_eligibility_check = FALSE
	var/ignore_holy_water = FALSE

/datum/antagonist/clockcult/ui_data(mob/user)
	. = ..()
	if(!.)
		return
	.["HONOR_RATVAR"] = GLOB.ratvar_awakens

/datum/antagonist/clockcult/neutered
	name = "Neutered Clock Cultist"
	neutered = TRUE
	soft_antag = TRUE
	ui_name = null // no.

/datum/antagonist/clockcult/neutered/traitor
	name = "Traitor Clock Cultist"
	ignore_eligibility_check = TRUE
	ignore_holy_water = TRUE
	show_in_roundend = FALSE
	make_team = FALSE

/datum/antagonist/clockcult/get_team()
	return clock_team

/datum/antagonist/clockcult/create_team(datum/team/clockcult/new_team)
	if(!new_team && make_team)
		//TODO blah blah same as the others, allow multiple
		for(var/datum/antagonist/clockcult/H in GLOB.antagonists)
			if(!H.owner)
				continue
			if(H.clock_team)
				clock_team = H.clock_team
				return
		clock_team = new /datum/team/clockcult
		return
	if(make_team && !istype(new_team))
		stack_trace("Wrong team type passed to [type] initialization.")
	clock_team = new_team

/datum/antagonist/clockcult/can_be_owned(datum/mind/new_owner)
	. = ..()
	if(. && !ignore_eligibility_check)
		. = is_eligible_servant(new_owner.current)

/datum/team/clockcult
	name = "Clockcult"
	var/list/objective
	var/datum/mind/eminence

/datum/game_mode
	/// A list of all minds currently in the cult
	var/list/datum/mind/clockwork_cult = list()
	var/datum/clockwork_objectives/clocker_objs = new
	/// Does the clockers have significant power stored
	var/power_reveal = FALSE
	/// Does the cult have halos
	var/crew_reveal = FALSE

	/// How many power need to be in supply to reveal
	var/power_reveal_number
	/// How many crew need to be converted to reveal
	var/crew_reveal_number
	/// Used for CentCom announcement when reached crew limit conversion
	var/reveal_percent

/proc/is_convertable_to_clocker(datum/mind/mind)
	if(!mind)
		return FALSE
	if(!mind.current)
		return FALSE
	if(iscultist(mind.current))
		return FALSE // Damn Narsie and his servants
	if(is_servant_of_ratvar(mind.current))
		return TRUE //If they're already in the cult, assume they are convertable
	if(mind.isholy)
		return FALSE
	if(ishuman(mind.current))
		var/mob/living/carbon/human/H = mind.current
		if(HAS_TRAIT(H, TRAIT_MINDSHIELD)) //mindshield protects against conversions unless removed
			return FALSE
	if(IS_GHOSTROLE(mind.current))
		return FALSE
	if(issilicon(mind.current))
		return FALSE //Can't be converted by platform. Have to use a clock slab as an emag.
	if(isguardian(mind.current))
		var/mob/living/simple_animal/hostile/guardian/G = mind.current
		if(!is_servant_of_ratvar(G.summoner))
			return FALSE //can't convert it unless the owner is converted
	return TRUE

/proc/adjust_clockwork_power(amount)
	GLOB.clockwork_power += amount
	SSticker.mode.check_power_reveal()
	SSticker.mode.clocker_objs.power_check()

/datum/game_mode/clockwork
	name = "Clockwork Cult"
	config_tag = "clockwork"
	restricted_jobs = list("Prisoner", "AI", "Cyborg")
	protected_jobs = list("Security Officer", "Shaft Miner", "Warden", "Detective", "Head of Security", "Captain", "Head of Personnel", "Chief Engineer", "Chief Medical Officer", "Research Director", "Quartermaster", "Blueshield", "Brig Physician", "Peacekeeper", "NanoTrasen Representative", "Lawyer", "Chaplain")
	required_players = 30
	required_enemies = 3
	recommended_enemies = 4

	var/const/max_clockers_to_start = 4

/datum/game_mode/clockwork/announce()
	to_chat(world, "<B>The current game mode is - Clockwork Cult!</B>")
	to_chat(world, "<B>Some crewmembers are attempting to start a clockwork cult!<BR>\nClockers - complete your objectives. Convert crewmembers to your cause by using the credence structure. Remember - there is no you, there is only the cult.<BR>\nPersonnel - Do not let the cult succeed in its mission. Brainwashing them with holy water reverts them to whatever CentComm-allowed faith they had.</B>")

/datum/game_mode/clockwork/pre_setup()
	if(CONFIG_GET(flag/protect_roles_from_antagonist))
		restricted_jobs += protected_jobs
	if(CONFIG_GET(flag/protect_assistant_from_antagonist))
		restricted_jobs += "Assistant"

	var/list/clockers_possible = get_players_for_role(ROLE_CLOCKER)
	for(var/clockers_number in 1 to max_clockers_to_start)
		if(!length(clockers_possible))
			break
		var/datum/mind/clocker = pick(clockers_possible)
		clockers_possible -= clocker
		clockwork_cult += clocker
		clocker.restricted_roles = restricted_jobs
		clocker.special_role = SPECIAL_ROLE_CLOCKER
	return (length(clockwork_cult) > 0)

/datum/game_mode/clockwork/post_setup()
	clocker_objs.setup()

	for(var/datum/mind/clockwork_mind in clockwork_cult)
		var/mob/living/carbon/H = clockwork_mind.current
		SEND_SOUND(clockwork_mind.current, 'sound/ambience/antag/ClockCultAlr.ogg')
		var/list/messages = list(CLOCK_GREETING)
		to_chat(clockwork_mind.current, chat_box_yellow(messages.Join("<br>")))
		equip_clocker(clockwork_mind.current)
		clockwork_mind.current.faction |= "ratvar"
		add_servant_of_ratvar(clockwork_mind.current)

		if(clockwork_mind.assigned_role == "Clown")
			to_chat(H, "Your training has allowed you to overcome your clownish nature, allowing you to wield weapons without harming yourself.")
			H.dna.remove_mutation(CLOWNMUT)

		add_clock_actions(clockwork_mind)
		update_clock_icons_added(clockwork_mind)
		clocker_objs.study(clockwork_mind.current)
	clockwork_threshold_check()
	addtimer(CALLBACK(src, PROC_REF(clockwork_threshold_check)), 2 MINUTES) // Check again in 2 minutes for latejoiners
	. = ..()

/datum/game_mode/clockwork/post_setup()
	clocker_objs.setup()

	for(var/datum/mind/clockwork_mind in clockwork_cult)
		SEND_SOUND(clockwork_mind.current, 'sound/ambience/antag/ClockCultAlr.ogg')
		var/list/messages = list(CLOCK_GREETING)
		to_chat(clockwork_mind.current, chat_box_yellow(messages.Join("<br>")))

		equip_clocker(clockwork_mind.current)
		add_servant_of_ratvar(clockwork_mind.current)

/**
  * Decides at the start of the round how many conversions are needed to reveal or how many power supplied to reveal.
  *
  * The number is decided by (Percentage * (Players - clockers)), so for example at 110 players it would be 16 conversions for rise. (0.15 * (110 - 4))
  * These values change based on population because 20 clockers are MUCH more powerful if there's only 50 players, compared to 120.
  *
  * Below 100 players, [CLOCK_POWER_REVEAL_LOW] and [CLOCK_CREW_REVEAL_LOW] are used.
  * Above 100 players, [CLOCK_POWER_REVEAL_HIGH] and [CLOCK_CREW_REVEAL_HIGH] are used.
  */
/datum/game_mode/proc/clockwork_threshold_check()
	var/players = length(GLOB.player_list)
	var/clockers = get_clockers() // Don't count the starting clockers towards the number of needed conversions
	if(players >= CLOCK_POPULATION_THRESHOLD)
		// Highpop
		reveal_percent = CLOCK_CREW_REVEAL_HIGH
		clocker_objs.power_goal = 1200 + length(GLOB.player_list)*CLOCK_POWER_PER_CREW_HIGH
		power_reveal_number = round(clocker_objs.power_goal * 0.67) // 2/3 of power goal
		crew_reveal_number = round(CLOCK_CREW_REVEAL_HIGH * (players - clockers),1)
	else
		// Lowpop
		reveal_percent = CLOCK_CREW_REVEAL_LOW
		clocker_objs.power_goal = 1200 + length(GLOB.player_list)*CLOCK_POWER_PER_CREW_LOW
		power_reveal_number = round(clocker_objs.power_goal * 0.67) // 2/3 of power goal
		crew_reveal_number = round(CLOCK_CREW_REVEAL_LOW * (players - clockers),1)
	log_game("Clockwork Cult power/crew reveal numbers: [power_reveal_number]/[crew_reveal_number].")

/**
  * Returns the current number of clockers and constructs.
  *
  * Returns the number of clockers and constructs in a list ([1] = Clockers, [2] = Constructs), or as one combined number.
  *
  * * separate - Should the number be returned in two separate values (Humans and Constructs) or as one?
  */
/datum/game_mode/proc/get_clockers(separate = FALSE)
	var/clockers = 0
	var/constructs = 0
	for(var/I in clockwork_cult)
		var/datum/mind/M = I
		if(ishuman(M.current))
			clockers++
		else if(istype(M.current, /mob/living/simple_animal/hostile/clockwork/marauder) && is_servant_of_ratvar(M.current))
			constructs++
	if(separate)
		return list(clockers, constructs)
	else
		return clockers + constructs

/datum/game_mode/proc/equip_clocker(mob/living/carbon/human/H, metal = TRUE)
	if(!istype(H))
		return
	. += clock_give_item(/obj/item/clockwork/clockslab, H)
	if(metal)
		. += clock_give_item(/obj/item/stack/sheet/brass/ten, H)
	to_chat(H, "<span class='clock'>Эти предметы помогут вам образовать культ на этой станции. Используйте их правильно и помните - вы не единственный.</span>")

/datum/game_mode/proc/clock_give_item(obj/item/item_path, mob/living/carbon/human/H)
	var/list/slots = list(
		"backpack" = ITEM_SLOT_BACKPACK,
		"left pocket" = ITEM_SLOT_LPOCKET,
		"right pocket" = ITEM_SLOT_RPOCKET
	)
	var/T = new item_path(H)
	var/item_name = initial(item_path.name)
	var/where = H.equip_in_one_of_slots(T, slots, qdel_on_fail = TRUE)
	if(!where)
		to_chat(H, "<span class='userdanger'>Unfortunately, you weren't able to get a [item_name]. This is very bad and you should adminhelp immediately (press F1).</span>")
		return FALSE
	else
		to_chat(H, "<span class='danger'>You have a [item_name] in your [where].</span>")
		return TRUE

/datum/game_mode/proc/add_clocker(datum/mind/clockwork_mind)
	var/mob/living/carbon/H = clockwork_mind.current
	if(!istype(clockwork_mind))
		return FALSE

	if(!reveal_percent) // If the rise/ascend thresholds haven't been set (non-cult rounds)
		clocker_objs.setup()
		clockwork_threshold_check()

	if(!(clockwork_mind in clockwork_cult))
		clockwork_cult += clockwork_mind
		clockwork_mind.current.faction |= "ratvar"
		clockwork_mind.special_role = SPECIAL_ROLE_CLOCKER

		if(clockwork_mind.assigned_role == "Clown")
			to_chat(H, "Your training has allowed you to overcome your clownish nature, allowing you to wield weapons without harming yourself.")
			H.dna.remove_mutation(CLOWNMUT)

		SEND_SOUND(clockwork_mind.current, 'sound/ambience/antag/clockcult.ogg')
		log_attack("[clockwork_mind.current] converted to the clockwork cult.")

		if(jobban_isbanned(clockwork_mind.current, ROLE_CLOCKER) || jobban_isbanned(clockwork_mind.current, ROLE_CULTIST) || jobban_isbanned(clockwork_mind.current, ROLE_SYNDICATE))
			replace_jobbanned_player(clockwork_mind.current, ROLE_CLOCKER)
		if(!clocker_objs.clock_status && ishuman(clockwork_mind.current))
			clocker_objs.setup()
		update_clock_icons_added(clockwork_mind)
		add_clock_actions(clockwork_mind)
		var/datum/objective/serveclock/obj = new
		obj.owner = clockwork_mind
		clockwork_mind.objectives += obj

		adjust_clockwork_power(CLOCK_POWER_CONVERT)

		if(power_reveal)
			powered(clockwork_mind.current)
		if(crew_reveal)
			clocked(clockwork_mind.current)
		check_clock_reveal()
		clocker_objs.study(clockwork_mind.current)
		return TRUE

/datum/game_mode/proc/remove_clocker(datum/mind/clockwork_mind, show_message = TRUE)
	if(!(clockwork_mind in clockwork_cult))
		return
	var/mob/clocker = clockwork_mind.current
	clockwork_cult -= clockwork_mind
	clocker.faction -= "ratvar"
	clockwork_mind.special_role = null
	for(var/datum/objective/serveclock/O in clockwork_mind.objectives)
		clockwork_mind.objectives -= O
		qdel(O)
	for(var/datum/action/innate/clockwork/C in clocker.actions)
		qdel(C)
	update_clock_icons_removed(clockwork_mind)

	if(ishuman(clocker))
		var/mob/living/carbon/human/H = clocker
		REMOVE_TRAIT(H, CLOCK_HANDS, null)
		H.change_eye_color(H.original_eye_color, FALSE)
		H.update_eyes()
		H.remove_overlay(ANTAG_LAYER)
		H.update_body()
	log_attack("[clocker] deconverted from the clockwork cult.")
	if(show_message)
		clocker.visible_message("<span class='clock'>[clocker] looks like [clocker.p_they()] just reverted to [clocker.p_their()] old faith!</span>",
		"<span class='userdanger'>An unfamiliar white light flashes through your mind, cleansing the taint of Ratvar and the memories of your time as their servant with it.</span>")

/datum/game_mode/proc/check_power_reveal()
	if(power_reveal)
		return
	if((GLOB.clockwork_power >= power_reveal_number) && !power_reveal)
		power_reveal = TRUE
		for(var/datum/mind/M in clockwork_cult)
			if(!M.current || !ishuman(M.current))
				continue
			SEND_SOUND(M.current, 'sound/hallucinations/i_see_you2.ogg')
			to_chat(M.current, "<span class='clocklarge'>The veil begins to stutter in fear as the power of Ratvar grows, your hands begin to glow...</span>")
			addtimer(CALLBACK(src, PROC_REF(powered), M.current), 20 SECONDS)

/datum/game_mode/proc/check_clock_reveal()
	if(crew_reveal)
		return
	var/clocker_players = get_clockers()
	if((clocker_players >= clocker_objs.clocker_goal) && !clocker_objs.obj_demand.clockers_get)
		clocker_objs.obj_demand.clockers_get = TRUE
		for(var/datum/mind/M in clockwork_cult)
			if(!M.current)
				continue
			to_chat(M.current, "<span class='clocklarge'>The army of my servants have grown. Now it will be easier...</span>")
			if(!clocker_objs.obj_demand.check_completion())
				to_chat(M.current, "<span class='clock'>But there's still more tasks to do.</span>")
			else
				clocker_objs.ratvar_is_ready()
	if((clocker_players >= crew_reveal_number) && !crew_reveal)
		crew_reveal = TRUE
		for(var/datum/mind/M in clockwork_cult)
			if(!M.current)
				continue
			SEND_SOUND(M.current, 'sound/hallucinations/im_here1.ogg')
			if(!ishuman(M.current))
				continue
			to_chat(M.current, "<span class='clocklarge'>Your cult gets bigger as the clocked harvest approaches - you cannot hide your true nature for much longer!")
			addtimer(CALLBACK(src, PROC_REF(clocked), M.current), 20 SECONDS)
		priority_announce("На вашей станции обнаружена внепространственная активность, связанная с Заводным культом Ратвара. Данные свидетельствуют о том, что в ряды культа обращено около [reveal_percent * 100]% экипажа станции. Служба безопасности получает право свободно применять летальную силу против культистов. Прочий персонал должен быть готов защищать себя и свои рабочие места от нападений культистов (в том числе используя летальную силу в качестве крайней меры самообороны), но не должен выслеживать культистов и охотиться на них. Погибшие члены экипажа должны быть оживлены и деконвертированы, как только ситуация будет взята под контроль.", "Отдел Центрального Командования по делам иных измерений.", 'sound/AI/commandreport.ogg')
		log_game("Clockwork cult reveal. Powergame allowed.")

/datum/game_mode/proc/powered(clocker)
	if(ishuman(clocker) && is_servant_of_ratvar(clocker))
		var/mob/living/carbon/human/H = clocker
		H.update_inv_gloves()
		ADD_TRAIT(H, CLOCK_HANDS, CLOCK_TRAIT)

/datum/game_mode/proc/clocked(clocker)
	if(ishuman(clocker) && is_servant_of_ratvar(clocker))
		var/mob/living/carbon/human/H = clocker
		new /obj/effect/temp_visual/ratvar/sparks(get_turf(H), H.dir)
		H.update_antag_layer()

/datum/game_mode/proc/add_clock_actions(datum/mind/clockwork_mind)
	if(clockwork_mind.current)
		var/datum/action/innate/clockwork/comm/C = new
		var/datum/action/innate/clockwork/check_progress/D = new
		C.Grant(clockwork_mind.current)
		D.Grant(clockwork_mind.current)
		if(ishuman(clockwork_mind.current) || issilicon(clockwork_mind.current) && !isAI(clockwork_mind.current))
			var/datum/action/innate/clockwork/clock_magic/magic = new
			magic.Grant(clockwork_mind.current)
		clockwork_mind.current.update_action_buttons(TRUE)

/datum/game_mode/proc/update_clock_icons_added(datum/mind/clockwork_mind)
	var/datum/atom_hud/antag/clockhud = GLOB.huds[ANTAG_HUD_CLOCKWORK]
	if(clockwork_mind.current)
		clockhud.join_hud(clockwork_mind.current)
		set_antag_hud(clockwork_mind.current, "clockwork")

/datum/game_mode/proc/update_clock_icons_removed(datum/mind/clockwork_mind)
	var/datum/atom_hud/antag/clockhud = GLOB.huds[ANTAG_HUD_CLOCKWORK]
	if(clockwork_mind.current)
		clockhud.leave_hud(clockwork_mind.current)
		set_antag_hud(clockwork_mind.current, null)

/datum/game_mode/clockwork/set_round_result()
	if(clocker_objs.clock_status == RATVAR_HAS_RISEN)
		SSticker.news_report = CLOCK_SUMMON
		SSticker.mode_result = "clockwork cult win - cult win"
	else if(clocker_objs.clock_status == RATVAR_HAS_FALLEN)
		SSticker.news_report = CULT_FAILURE
		SSticker.mode_result = "clockwork cult draw - ratvar died, nobody wins"
	else
		SSticker.mode_result = "clockwork cult loss - staff stopped the cult"

	var/endtext
	endtext += "<br><b>The clockers' objectives were:</b>"
	endtext += "<br>[clocker_objs.obj_demand.explanation_text] - "
	if(!clocker_objs.obj_demand.check_completion())
		endtext += "<font color='red'>Fail.</font>"
	else
		endtext += "<font color='green'><B>Success!</B></font>"

	if(clocker_objs.clock_status >= RATVAR_NEEDS_SUMMONING)
		endtext += "<br>[clocker_objs.obj_summon.explanation_text] - "
		if(!clocker_objs.obj_summon.check_completion())
			endtext+= "<font color='red'>Fail.</font>"
		else
			endtext += "<font color='green'><B>Success!</B></font>"

	to_chat(world, endtext)
	. = ..()
