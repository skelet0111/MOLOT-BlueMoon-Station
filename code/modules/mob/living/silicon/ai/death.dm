/mob/living/silicon/ai/death(gibbed)
	if(stat == DEAD)
		return

	if(!gibbed)
		// Will update all AI status displays with a blue screen of death
		INVOKE_ASYNC(src, PROC_REF(emote), "bsod")

	if(!isnull(deployed_shell))
		disconnect_shell()

	. = ..()

	var/old_icon = icon_state
	if("[icon_state]_dead" in icon_states(icon))
		icon_state = "[icon_state]_dead"
	else
		icon_state = "ai_dead"
	if("[old_icon]_death_transition" in icon_states(icon))
		flick("[old_icon]_death_transition", src)

	cameraFollow = null

	if(is_anchored)
		flip_anchored()

	//Citadel-Station Edit start
	move_resist = MOVE_FORCE_NORMAL
	update_mobility()
	//Citadel-Station Edit end

	if(eyeobj)
		eyeobj.setLoc(get_turf(src))
		set_eyeobj_visible(FALSE)

	GLOB.shuttle_caller_list -= src
	SSshuttle.autoEvac()

	ShutOffDoomsdayDevice()

	if(explosive)
		addtimer(CALLBACK(GLOBAL_PROC, GLOBAL_PROC_REF(explosion), loc, 3, 6, 12, null, 15), 1 SECONDS)

	if(istype(loc, /obj/item/aicard/aitater))
		loc.icon_state = "aitater-404"
	else if(istype(loc, /obj/item/aicard/aispook))
		loc.icon_state = "aispook-404"
	else if(istype(loc, /obj/item/aicard))
		loc.icon_state = "aicard-404"

	SSblackbox.ReportDeath(src)

/mob/living/silicon/ai/proc/ShutOffDoomsdayDevice()
	if(nuking)
		set_security_level("red")
		nuking = FALSE
		for(var/obj/item/pinpointer/nuke/P in GLOB.pinpointer_list)
			P.switch_mode_to(TRACK_NUKE_DISK) //Party's over, back to work, everyone
			P.alert = FALSE

	if(doomsday_device)
		doomsday_device.timing = FALSE
		SSshuttle.clearHostileEnvironment(doomsday_device)
		qdel(doomsday_device)
