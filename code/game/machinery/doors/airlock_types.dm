/*
	Station Airlocks Regular
*/

/obj/machinery/door/airlock/abandoned
	abandoned = TRUE

/obj/machinery/door/airlock/command
	icon = 'icons/obj/doors/airlocks/station/command.dmi'
	assemblytype = /obj/structure/door_assembly/door_assembly_com
	wiretypepath = /datum/wires/airlock/command
	normal_integrity = 450

/obj/machinery/door/airlock/security
	icon = 'icons/obj/doors/airlocks/station/security.dmi'
	assemblytype = /obj/structure/door_assembly/door_assembly_sec
	wiretypepath = /datum/wires/airlock/security
	normal_integrity = 450

/obj/machinery/door/airlock/engineering
	icon = 'icons/obj/doors/airlocks/station/engineering.dmi'
	assemblytype = /obj/structure/door_assembly/door_assembly_eng
	wiretypepath = /datum/wires/airlock/engineering

/obj/machinery/door/airlock/engineering/abandoned
	abandoned = TRUE

/obj/machinery/door/airlock/medical
	icon = 'icons/obj/doors/airlocks/station/medical.dmi'
	assemblytype = /obj/structure/door_assembly/door_assembly_med
	wiretypepath = /datum/wires/airlock/medical

/obj/machinery/door/airlock/maintenance
	name = "maintenance access"
	icon = 'icons/obj/doors/airlocks/station/maintenance.dmi'
	assemblytype = /obj/structure/door_assembly/door_assembly_mai
	normal_integrity = 250

/obj/machinery/door/airlock/maintenance/abandoned
	abandoned = TRUE

/obj/machinery/door/airlock/maintenance/external
	name = "external airlock access"
	icon = 'icons/obj/doors/airlocks/station/maintenanceexternal.dmi'
	assemblytype = /obj/structure/door_assembly/door_assembly_extmai

/obj/machinery/door/airlock/mining
	name = "mining airlock"
	icon = 'icons/obj/doors/airlocks/station/mining.dmi'
	assemblytype = /obj/structure/door_assembly/door_assembly_min
	wiretypepath = /datum/wires/airlock/cargo

/obj/machinery/door/airlock/atmos
	name = "atmospherics airlock"
	icon = 'icons/obj/doors/airlocks/station/atmos.dmi'
	assemblytype = /obj/structure/door_assembly/door_assembly_atmo
	wiretypepath = /datum/wires/airlock/engineering

/obj/machinery/door/airlock/atmos/abandoned
	abandoned = TRUE

/obj/machinery/door/airlock/research
	icon = 'icons/obj/doors/airlocks/station/research.dmi'
	assemblytype = /obj/structure/door_assembly/door_assembly_research
	wiretypepath = /datum/wires/airlock/science

/obj/machinery/door/airlock/freezer
	name = "freezer airlock"
	icon = 'icons/obj/doors/airlocks/station/freezer.dmi'
	assemblytype = /obj/structure/door_assembly/door_assembly_fre

/obj/machinery/door/airlock/science
	icon = 'icons/obj/doors/airlocks/station/science.dmi'
	assemblytype = /obj/structure/door_assembly/door_assembly_science
	wiretypepath = /datum/wires/airlock/science

/obj/machinery/door/airlock/virology
	icon = 'icons/obj/doors/airlocks/station/virology.dmi'
	assemblytype = /obj/structure/door_assembly/door_assembly_viro
	wiretypepath = /datum/wires/airlock/medical

//////////////////////////////////
/*
	Station Airlocks Glass
*/

/obj/machinery/door/airlock/glass
	opacity = 0
	glass = TRUE

/obj/machinery/door/airlock/glass/incinerator
	autoclose = FALSE
	frequency = FREQ_AIRLOCK_CONTROL
	heat_proof = TRUE
	req_access = list(ACCESS_SYNDICATE)

/obj/machinery/door/airlock/glass/incinerator/syndicatelava_interior
	name = "Turbine Interior Airlock"
	id_tag = INCINERATOR_SYNDICATELAVA_AIRLOCK_INTERIOR

/obj/machinery/door/airlock/glass/incinerator/syndicatelava_exterior
	name = "Turbine Exterior Airlock"
	id_tag = INCINERATOR_SYNDICATELAVA_AIRLOCK_EXTERIOR

/obj/machinery/door/airlock/command/glass
	opacity = 0
	glass = TRUE
	normal_integrity = 400

/obj/machinery/door/airlock/engineering/glass
	opacity = 0
	glass = TRUE

/obj/machinery/door/airlock/engineering/glass/critical
	critical_machine = TRUE //stops greytide virus from opening & bolting doors in critical positions, such as the SM chamber.

/obj/machinery/door/airlock/security/glass
	opacity = 0
	glass = TRUE
	normal_integrity = 400

/obj/machinery/door/airlock/security/glass/abandoned
	abandoned = TRUE

/obj/machinery/door/airlock/medical/glass
	opacity = 0
	glass = TRUE

/obj/machinery/door/airlock/research/glass
	opacity = 0
	glass = TRUE

/obj/machinery/door/airlock/research/glass/incinerator
	autoclose = FALSE
	frequency = FREQ_AIRLOCK_CONTROL
	heat_proof = TRUE
	req_access = list(ACCESS_TOX)

/obj/machinery/door/airlock/research/glass/incinerator/toxmix_interior
	name = "Mixing Room Interior Airlock"
	id_tag = INCINERATOR_TOXMIX_AIRLOCK_INTERIOR

/obj/machinery/door/airlock/research/glass/incinerator/toxmix_exterior
	name = "Mixing Room Exterior Airlock"
	id_tag = INCINERATOR_TOXMIX_AIRLOCK_EXTERIOR

/obj/machinery/door/airlock/mining/glass
	opacity = 0
	glass = TRUE

/obj/machinery/door/airlock/atmos/glass
	opacity = 0
	glass = TRUE

/obj/machinery/door/airlock/atmos/glass/critical
	critical_machine = TRUE //stops greytide virus from opening & bolting doors in critical positions, such as the SM chamber.

/obj/machinery/door/airlock/science/glass
	opacity = 0
	glass = TRUE

/obj/machinery/door/airlock/virology/glass
	opacity = 0
	glass = TRUE

/obj/machinery/door/airlock/maintenance/glass
	opacity = 0
	glass = TRUE

/obj/machinery/door/airlock/maintenance/external/glass
	opacity = 0
	glass = TRUE
	normal_integrity = 200

//////////////////////////////////
/*
	Station Airlocks Mineral
*/

/obj/machinery/door/airlock/gold
	name = "gold airlock"
	icon = 'icons/obj/doors/airlocks/station/gold.dmi'
	assemblytype = /obj/structure/door_assembly/door_assembly_gold

/obj/machinery/door/airlock/gold/glass
	opacity = 0
	glass = TRUE

/obj/machinery/door/airlock/silver
	name = "silver airlock"
	icon = 'icons/obj/doors/airlocks/station/silver.dmi'
	assemblytype = /obj/structure/door_assembly/door_assembly_silver

/obj/machinery/door/airlock/silver/glass
	opacity = 0
	glass = TRUE

/obj/machinery/door/airlock/diamond
	name = "diamond airlock"
	icon = 'icons/obj/doors/airlocks/station/diamond.dmi'
	assemblytype = /obj/structure/door_assembly/door_assembly_diamond
	normal_integrity = 1000
	explosion_block = 2

/obj/machinery/door/airlock/diamond/glass
	normal_integrity = 950
	opacity = 0
	glass = TRUE

/obj/machinery/door/airlock/uranium
	name = "uranium airlock"
	icon = 'icons/obj/doors/airlocks/station/uranium.dmi'
	assemblytype = /obj/structure/door_assembly/door_assembly_uranium
	var/last_event = 0

/obj/machinery/door/airlock/uranium/process()
	if(world.time > last_event+20)
		if(prob(50))
			radiate()
		last_event = world.time
	..()

/obj/machinery/door/airlock/uranium/proc/radiate()
	radiation_pulse(get_turf(src), 150)
	return

/obj/machinery/door/airlock/uranium/glass
	opacity = 0
	glass = TRUE

/obj/machinery/door/airlock/plasma
	name = "plasma airlock"
	desc = "No way this can end badly."
	icon = 'icons/obj/doors/airlocks/station/plasma.dmi'
	assemblytype = /obj/structure/door_assembly/door_assembly_plasma

/obj/machinery/door/airlock/plasma/temperature_expose(datum/gas_mixture/air, exposed_temperature, exposed_volume)
	if(exposed_temperature > 300)
		PlasmaBurn(exposed_temperature)

/obj/machinery/door/airlock/plasma/proc/ignite(exposed_temperature)
	if(exposed_temperature > 300)
		PlasmaBurn(exposed_temperature)

/obj/machinery/door/airlock/plasma/proc/PlasmaBurn(temperature)
	atmos_spawn_air("plasma=500;TEMP=1000")
	var/obj/structure/door_assembly/DA
	DA = new /obj/structure/door_assembly(loc)
	if(glass)
		DA.glass = TRUE
	if(heat_proof)
		DA.heat_proof_finished = TRUE
	DA.update_icon()
	DA.update_name()
	qdel(src)

/obj/machinery/door/airlock/plasma/BlockThermalConductivity() //we don't stop the heat~
	return 0

/obj/machinery/door/airlock/plasma/attackby(obj/item/C, mob/user, params)
	if(C.get_temperature() > 300)//If the temperature of the object is over 300, then ignite
		message_admins("Plasma airlock ignited by [ADMIN_LOOKUPFLW(user)] in [ADMIN_VERBOSEJMP(src)]")
		log_admin("Plasma airlock ignited by [key_name(user)] in [AREACOORD(src)]")
		ignite(C.get_temperature())
	else
		return ..()

/obj/machinery/door/airlock/plasma/glass
	opacity = 0
	glass = TRUE

/obj/machinery/door/airlock/bananium
	name = "bananium airlock"
	desc = "Honkhonkhonk"
	icon = 'icons/obj/doors/airlocks/station/bananium.dmi'
	assemblytype = /obj/structure/door_assembly/door_assembly_bananium
	doorOpen = 'sound/items/bikehorn.ogg'

/obj/machinery/door/airlock/bananium/glass
	opacity = 0
	glass = TRUE

/obj/machinery/door/airlock/sandstone
	name = "sandstone airlock"
	icon = 'icons/obj/doors/airlocks/station/sandstone.dmi'
	assemblytype = /obj/structure/door_assembly/door_assembly_sandstone

/obj/machinery/door/airlock/sandstone/glass
	opacity = 0
	glass = TRUE

/obj/machinery/door/airlock/wood
	name = "wooden airlock"
	icon = 'icons/obj/doors/airlocks/station/wood.dmi'
	assemblytype = /obj/structure/door_assembly/door_assembly_wood

/obj/machinery/door/airlock/wood/glass
	opacity = 0
	glass = TRUE

/obj/machinery/door/airlock/titanium
	name = "shuttle airlock"
	assemblytype = /obj/structure/door_assembly/door_assembly_titanium
	icon = 'icons/obj/doors/airlocks/shuttle/shuttle.dmi'
	overlays_file = 'icons/obj/doors/airlocks/shuttle/overlays.dmi'
	normal_integrity = 400

/obj/machinery/door/airlock/titanium/glass
	normal_integrity = 350
	opacity = 0
	glass = TRUE

/obj/machinery/door/airlock/bronze
	name = "bronze airlock"
	icon = 'icons/obj/doors/airlocks/clockwork/pinion_airlock.dmi'
	overlays_file = 'icons/obj/doors/airlocks/clockwork/overlays.dmi'
	assemblytype = /obj/structure/door_assembly/door_assembly_bronze

/obj/machinery/door/airlock/bronze/seethru
	assemblytype = /obj/structure/door_assembly/door_assembly_bronze/seethru
	opacity = 0
	glass = TRUE

//////////////////////////////////
/*
	Station2 Airlocks
*/

/obj/machinery/door/airlock/public
	icon = 'icons/obj/doors/airlocks/station2/glass.dmi'
	overlays_file = 'icons/obj/doors/airlocks/station2/overlays.dmi'
	assemblytype = /obj/structure/door_assembly/door_assembly_public

/obj/machinery/door/airlock/public/glass
	opacity = 0
	glass = TRUE

/obj/machinery/door/airlock/public/glass/incinerator
	autoclose = FALSE
	frequency = FREQ_AIRLOCK_CONTROL
	heat_proof = TRUE
	req_one_access = list(ACCESS_ATMOSPHERICS, ACCESS_MAINT_TUNNELS)

/obj/machinery/door/airlock/public/glass/incinerator/atmos_interior
	name = "Turbine Interior Airlock"
	id_tag = INCINERATOR_ATMOS_AIRLOCK_INTERIOR

/obj/machinery/door/airlock/public/glass/incinerator/atmos_exterior
	name = "Turbine Exterior Airlock"
	id_tag = INCINERATOR_ATMOS_AIRLOCK_EXTERIOR

//////////////////////////////////
/*
	External Airlocks
*/

/obj/machinery/door/airlock/external
	name = "external airlock"
	icon = 'icons/obj/doors/airlocks/external/external.dmi'
	overlays_file = 'icons/obj/doors/airlocks/external/overlays.dmi'
	note_overlay_file = 'icons/obj/doors/airlocks/external/overlays.dmi'
	assemblytype = /obj/structure/door_assembly/door_assembly_ext

/obj/machinery/door/airlock/external/glass
	opacity = 0
	glass = TRUE

/// Access free external glass airlock
/obj/machinery/door/airlock/external/glass/ruin

//////////////////////////////////
/*
	CentCom Airlocks
*/

/obj/machinery/door/airlock/centcom //Use grunge as a station side version, as these have special effects related to them via phobias and such.
	icon = 'icons/obj/doors/airlocks/centcom/centcom.dmi'
	overlays_file = 'icons/obj/doors/airlocks/centcom/overlays.dmi'
	assemblytype = /obj/structure/door_assembly/door_assembly_centcom
	normal_integrity = 1000
	security_level = 6
	explosion_block = 2

/obj/machinery/door/airlock/grunge
	icon = 'icons/obj/doors/airlocks/centcom/centcom.dmi'
	overlays_file = 'icons/obj/doors/airlocks/centcom/overlays.dmi'
	assemblytype = /obj/structure/door_assembly/door_assembly_grunge

/obj/machinery/door/airlock/grunge/abandoned
	abandoned = TRUE

//////////////////////////////////
/*
	Vault Airlocks
*/

/obj/machinery/door/airlock/vault
	name = "vault door"
	icon = 'icons/obj/doors/airlocks/vault/vault.dmi'
	overlays_file = 'icons/obj/doors/airlocks/vault/overlays.dmi'
	assemblytype = /obj/structure/door_assembly/door_assembly_vault
	wiretypepath = /datum/wires/airlock/secure
	explosion_block = 2
	normal_integrity = 400 // reverse engieneerd: 400 * 1.5 (sec lvl 6) = 600 = original
	security_level = 6

//////////////////////////////////
/*
	Hatch Airlocks
*/

/obj/machinery/door/airlock/hatch
	name = "airtight hatch"
	icon = 'icons/obj/doors/airlocks/hatch/centcom.dmi'
	overlays_file = 'icons/obj/doors/airlocks/hatch/overlays.dmi'
	note_overlay_file = 'icons/obj/doors/airlocks/hatch/overlays.dmi'
	assemblytype = /obj/structure/door_assembly/door_assembly_hatch

/obj/machinery/door/airlock/maintenance_hatch
	name = "maintenance hatch"
	icon = 'icons/obj/doors/airlocks/hatch/maintenance.dmi'
	overlays_file = 'icons/obj/doors/airlocks/hatch/overlays.dmi'
	note_overlay_file = 'icons/obj/doors/airlocks/hatch/overlays.dmi'
	assemblytype = /obj/structure/door_assembly/door_assembly_mhatch

/obj/machinery/door/airlock/maintenance_hatch/abandoned
	abandoned = TRUE

//////////////////////////////////
/*
	High Security Airlocks
*/

/obj/machinery/door/airlock/highsecurity
	name = "high tech security airlock"
	icon = 'icons/obj/doors/airlocks/highsec/highsec.dmi'
	overlays_file = 'icons/obj/doors/airlocks/highsec/overlays.dmi'
	assemblytype = /obj/structure/door_assembly/door_assembly_highsecurity
	explosion_block = 2
	normal_integrity = 500
	security_level = 1
	damage_deflection = 30

//////////////////////////////////
/*
	Shuttle Airlocks
*/

/obj/machinery/door/airlock/shuttle
	name = "shuttle airlock"
	icon = 'icons/obj/doors/airlocks/shuttle/shuttle.dmi'
	overlays_file = 'icons/obj/doors/airlocks/shuttle/overlays.dmi'
	assemblytype = /obj/structure/door_assembly/door_assembly_shuttle

/obj/machinery/door/airlock/shuttle/glass
	opacity = 0
	glass = TRUE

/obj/machinery/door/airlock/abductor
	name = "alien airlock"
	desc = "With humanity's current technological level, it could take years to hack this advanced airlock... or maybe we should give a screwdriver a try?"
	icon = 'icons/obj/doors/airlocks/abductor/abductor_airlock.dmi'
	overlays_file = 'icons/obj/doors/airlocks/abductor/overlays.dmi'
	assemblytype = /obj/structure/door_assembly/door_assembly_abductor
	note_overlay_file = 'icons/obj/doors/airlocks/external/overlays.dmi'
	damage_deflection = 30
	explosion_block = 3
	hackProof = TRUE
	aiControlDisabled = 1
	normal_integrity = 700
	security_level = 1

//////////////////////////////////
/*
	Cult Airlocks
*/

/obj/machinery/door/airlock/cult
	name = "cult airlock"
	icon = 'icons/obj/doors/airlocks/cult/runed/cult.dmi'
	overlays_file = 'icons/obj/doors/airlocks/cult/runed/overlays.dmi'
	assemblytype = /obj/structure/door_assembly/door_assembly_cult
	hackProof = TRUE
	aiControlDisabled = 1
	req_access = list(ACCESS_BLOODCULT)
	damage_deflection = 10
	var/openingoverlaytype = /obj/effect/temp_visual/cult/door
	var/friendly = FALSE
	var/stealthy = FALSE

/obj/machinery/door/airlock/cult/Initialize(mapload)
	. = ..()
	new openingoverlaytype(loc)

/obj/machinery/door/airlock/cult/canAIControl(mob/user)
	return (iscultist(user) && !isAllPowerCut())

/obj/machinery/door/airlock/cult/obj_break(damage_flag)
	if(!(flags_1 & BROKEN) && !(flags_1 & NODECONSTRUCT_1))
		stat |= BROKEN
		if(!panel_open)
			panel_open = TRUE
		update_icon()

/obj/machinery/door/airlock/cult/isElectrified()
	return FALSE

/obj/machinery/door/airlock/cult/hasPower()
	return TRUE

/obj/machinery/door/airlock/cult/allowed(mob/living/L)
	if(!density)
		return 1
	if(friendly || iscultist(L) || isshade(L) || isconstruct(L))
		if(!stealthy)
			new openingoverlaytype(loc)
		return 1
	else
		if(!stealthy)
			new /obj/effect/temp_visual/cult/sac(loc)
			var/atom/throwtarget
			throwtarget = get_edge_target_turf(src, get_dir(src, get_step_away(L, src)))
			SEND_SOUND(L, sound(pick('sound/hallucinations/turn_around1.ogg','sound/hallucinations/turn_around2.ogg'),0,1,50))
			flash_color(L, flash_color="#960000", flash_time=20)
			L.DefaultCombatKnockdown(40)
			L.throw_at(throwtarget, 5, 1)
		return 0

/obj/machinery/door/airlock/cult/proc/conceal()
	icon = 'icons/obj/doors/airlocks/station/maintenance.dmi'
	overlays_file = 'icons/obj/doors/airlocks/station/overlays.dmi'
	name = "airlock"
	desc = "It opens and closes."
	stealthy = TRUE
	update_icon()

/obj/machinery/door/airlock/cult/proc/reveal()
	icon = initial(icon)
	overlays_file = initial(overlays_file)
	name = initial(name)
	desc = initial(desc)
	stealthy = initial(stealthy)
	update_icon()

/obj/machinery/door/airlock/cult/narsie_act()
	return

/obj/machinery/door/airlock/cult/ratvar_act()
	new /obj/machinery/door/airlock/clockwork(get_turf(src))
	qdel(src)

/obj/machinery/door/airlock/cult/emp_act(severity)
	return

/obj/machinery/door/airlock/cult/friendly
	friendly = TRUE

/obj/machinery/door/airlock/cult/glass
	glass = TRUE
	opacity = 0

/obj/machinery/door/airlock/cult/glass/friendly
	friendly = TRUE

/obj/machinery/door/airlock/cult/unruned
	icon = 'icons/obj/doors/airlocks/cult/unruned/cult.dmi'
	overlays_file = 'icons/obj/doors/airlocks/cult/unruned/overlays.dmi'
	assemblytype = /obj/structure/door_assembly/door_assembly_cult/unruned
	openingoverlaytype = /obj/effect/temp_visual/cult/door/unruned

/obj/machinery/door/airlock/cult/unruned/friendly
	friendly = TRUE

/obj/machinery/door/airlock/cult/unruned/glass
	glass = TRUE
	opacity = 0

/obj/machinery/door/airlock/cult/unruned/glass/friendly
	friendly = TRUE

/obj/machinery/door/airlock/cult/weak
	name = "Brittle Cult Airlock"
	desc = "An airlock hastily corrupted by blood magic, it is unusually brittle in this state."
	normal_integrity = 150
	damage_deflection = 5
	armor = list(MELEE = 0, BULLET = 0, LASER = 0,ENERGY = 0, BOMB = 0, BIO = 0, RAD = 0, FIRE = 0, ACID = 0)

//////////////////////////////////
/*
	Clockwork Airlocks
*/

/obj/machinery/door/airlock/clockwork
	name = "clockwork airlock"
	icon = 'icons/obj/doors/airlocks/clockwork/pinion_airlock.dmi'
	overlays_file = 'icons/obj/doors/airlocks/clockwork/overlays.dmi'
	assemblytype = /obj/structure/door_assembly/door_assembly_clock
	damage_deflection = 10
	hackProof = TRUE
	aiControlDisabled = AICONTROLDISABLED_ON
	paintable = FALSE
	/// Will the door let anyone through
	var/friendly = FALSE

/obj/machinery/door/airlock/clockwork/Initialize()
	. = ..()
	new /obj/effect/temp_visual/ratvar/door(get_turf(src))

/obj/machinery/door/airlock/clockwork/canAIControl(mob/user)
	return (is_servant_of_ratvar(user) && !isAllPowerLoss())

/obj/machinery/door/airlock/clockwork/allowed(mob/living/L)
	if(!density)
		return TRUE
	if(friendly || is_servant_of_ratvar(L))
		return TRUE
	else
		new /obj/effect/temp_visual/ratvar/door(loc)
		var/atom/throwtarget
		throwtarget = get_edge_target_turf(src, get_dir(src, get_step_away(L, src)))
		SEND_SOUND(L, pick(sound('sound/hallucinations/turn_around1.ogg', 0, 1, 50), sound('sound/hallucinations/turn_around2.ogg', 0, 1, 50)))
		L.Weaken(4 SECONDS)
		L.throw_at(throwtarget, 5, 1,src)
		return FALSE

/obj/machinery/door/airlock/clockwork/narsie_act()
	new /obj/machinery/door/airlock/cult(get_turf(src))
	qdel(src)

/obj/machinery/door/airlock/clockwork/ratvar_act()
	return

/obj/machinery/door/airlock/clockwork/friendly
	friendly = TRUE

/obj/machinery/door/airlock/clockwork/glass
	glass = TRUE
	opacity = 0

/obj/machinery/door/airlock/clockwork/glass/friendly
	friendly = TRUE

/obj/machinery/door/airlock/clockwork/weak
	name = "Brittle Clockwork Airlock"
	desc = "An airlock made from pure-hands into some brass moving structure."
	normal_integrity = 150
	damage_deflection = 5
	armor = list(MELEE = 0, BULLET = 0, LASER = 0,ENERGY = 0, BOMB = 0, BIO = 0, RAD = 0, FIRE = 0, ACID = 0)

//////////////////////////////////
/*
	Misc Airlocks
*/

/obj/machinery/door/airlock/glass_large
	name = "large glass airlock"
	icon = 'icons/obj/doors/airlocks/glass_large/glass_large.dmi'
	overlays_file = 'icons/obj/doors/airlocks/glass_large/overlays.dmi'
	opacity = 0
	assemblytype = null
	glass = TRUE
	bound_width = 64 // 2x1

/obj/machinery/door/airlock/glass_large/narsie_act()
	return

//////////////////////////////////
/*
	Material Airlocks
*/
/obj/machinery/door/airlock/material
	name = "Airlock"
	material_flags = MATERIAL_COLOR | MATERIAL_ADD_PREFIX | MATERIAL_AFFECT_STATISTICS
	assemblytype = /obj/structure/door_assembly/door_assembly_material

/obj/machinery/door/airlock/material/close(forced, force_crush)
	. = ..()
	if(!.)
		return
	for(var/datum/material/mat in custom_materials)
		if(mat.alpha < 255)
			set_opacity(FALSE)
			break

/obj/machinery/door/airlock/material/prepare_deconstruction_assembly(obj/structure/door_assembly/assembly)
	assembly.set_custom_materials(custom_materials)
	..()

/obj/machinery/door/airlock/material/glass
	opacity = FALSE
	glass = TRUE
