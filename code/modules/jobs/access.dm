
//returns TRUE if this mob has sufficient access to use this object
/obj/proc/allowed(mob/M)
	//check if it doesn't require any access at all
	if(check_access(null))
		return TRUE
	if(!M)
		return FALSE
	if(hasSiliconAccessInArea(M))
		return TRUE	//AI, robots and adminghosts can do whatever they want
	else if(SEND_SIGNAL(M, COMSIG_MOB_ALLOWED, src))
		return TRUE
	else if(ishuman(M))
		var/mob/living/carbon/human/H = M
		//if they are holding or wearing a card that has access, that works
		if(check_access(H.get_active_held_item()) || src.check_access(H.wear_id) || src.check_access(H.wear_neck))
			return TRUE
	else if(ismonkey(M) || isalienadult(M))
		var/mob/living/carbon/george = M
		//they can only hold things :(
		if(check_access(george.get_active_held_item()))
			return TRUE
	else if(isanimal(M))
		var/mob/living/simple_animal/A = M
		if(check_access(A.get_active_held_item()) || check_access(A.access_card))
			return TRUE
	return FALSE

/obj/item/proc/GetAccess()
	return list()

/obj/item/proc/GetID()
	return null

/obj/item/proc/RemoveID()
	return null

/obj/item/proc/InsertID()
	return FALSE

/obj/proc/text2access(access_text)
	. = list()
	if(!access_text)
		return
	var/list/split = splittext(access_text,";")
	for(var/x in split)
		var/n = text2num(x)
		if(n)
			. += n

//Call this before using req_access or req_one_access directly
/obj/proc/gen_access()
	//These generations have been moved out of /obj/New() because they were slowing down the creation of objects that never even used the access system.
	if(!req_access)
		req_access = list()
		for(var/a in text2access(req_access_txt))
			req_access += a
	if(!req_one_access)
		req_one_access = list()
		for(var/b in text2access(req_one_access_txt))
			req_one_access += b

// Check if an item has access to this object
/obj/proc/check_access(obj/item/I)
	return check_access_list(I ? I.GetAccess() : null)

/obj/proc/check_access_list(list/access_list)
	gen_access()

	if(!islist(req_access)) //something's very wrong
		return TRUE

	if(!req_access.len && !length(req_one_access))
		return TRUE

	if(!length(access_list) || !islist(access_list))
		return FALSE

	for(var/req in req_access)
		if(!(req in access_list)) //doesn't have this access
			return FALSE

	if(length(req_one_access))
		for(var/req in req_one_access)
			if(req in access_list) //has an access from the single access list
				return TRUE
		return FALSE
	return TRUE

/obj/proc/check_access_ntnet(datum/netdata/data)
	return check_access_list(data.passkey)

/proc/get_centcom_access(job)
	switch(job)
		if("VIP Guest")
			return list(ACCESS_CENT_GENERAL)
		if("Custodian")
			return list(ACCESS_CENT_GENERAL, ACCESS_CENT_LIVING, ACCESS_CENT_STORAGE)
		if("Thunderdome Overseer")
			return list(ACCESS_CENT_GENERAL, ACCESS_CENT_THUNDER)
		if("CentCom Official")
			return list(ACCESS_CENT_GENERAL, ACCESS_CENT_LIVING, ACCESS_CENT_THUNDER, ACCESS_BRIDGE_OFFICER, ACCESS_HEADS)
		if("Medical Officer")
			return list(ACCESS_CENT_GENERAL, ACCESS_CENT_LIVING, ACCESS_CENT_MEDICAL)
		if("Death Commando")
			return list(ACCESS_CENT_GENERAL, ACCESS_CENT_SPECOPS, ACCESS_CENT_LIVING, ACCESS_CENT_STORAGE)
		if("Research Officer")
			return list(ACCESS_CENT_GENERAL, ACCESS_CENT_SPECOPS, ACCESS_CENT_MEDICAL, ACCESS_CENT_TELEPORTER, ACCESS_CENT_STORAGE)
		if("Special Ops Officer")
			return get_all_centcom_access()
		if("Admiral")
			return get_all_centcom_access()
		if("CentCom Commander")
			return get_all_centcom_access()
		if("Emergency Response Team Commander")
			return get_ert_access("commander")
		if("Security Response Officer")
			return get_ert_access("sec")
		if("Engineer Response Officer")
			return get_ert_access("eng")
		if("Medical Response Officer")
			return get_ert_access("med")
		if("CentCom Bartender")
			return list(ACCESS_CENT_GENERAL, ACCESS_CENT_LIVING, ACCESS_CENT_BAR)

/proc/get_all_accesses()
	return list(ACCESS_SECURITY, ACCESS_SEC_DOORS, ACCESS_BRIG, ACCESS_ARMORY, ACCESS_FORENSICS_LOCKERS, ACCESS_COURT, ACCESS_ENTER_GENPOP, ACCESS_LEAVE_GENPOP,
				ACCESS_MEDICAL, ACCESS_GENETICS, ACCESS_MORGUE, ACCESS_RD,
				ACCESS_TOX, ACCESS_TOX_STORAGE, ACCESS_CHEMISTRY, ACCESS_ENGINE, ACCESS_ENGINE_EQUIP, ACCESS_MAINT_TUNNELS,
				ACCESS_EXTERNAL_AIRLOCKS, ACCESS_CHANGE_IDS, ACCESS_AI_UPLOAD,
				ACCESS_TELEPORTER, ACCESS_EVA, ACCESS_HEADS, ACCESS_CAPTAIN, ACCESS_ALL_PERSONAL_LOCKERS,
				ACCESS_TECH_STORAGE, ACCESS_CHAPEL_OFFICE, ACCESS_ATMOSPHERICS, ACCESS_KITCHEN,
				ACCESS_BAR, ACCESS_JANITOR, ACCESS_CREMATORIUM, ACCESS_ROBOTICS, ACCESS_CARGO, ACCESS_CONSTRUCTION,
				ACCESS_HYDROPONICS, ACCESS_LIBRARY, ACCESS_LAWYER, ACCESS_VIROLOGY, ACCESS_CMO, ACCESS_QM, ACCESS_SURGERY,
				ACCESS_THEATRE, ACCESS_RESEARCH, ACCESS_MINING, ACCESS_MAILSORTING, ACCESS_WEAPONS,
				ACCESS_VAULT, ACCESS_MINING_STATION, ACCESS_XENOBIOLOGY, ACCESS_CE, ACCESS_HOP, ACCESS_HOS, ACCESS_RC_ANNOUNCE,
				ACCESS_KEYCARD_AUTH, ACCESS_TCOMSAT, ACCESS_GATEWAY, ACCESS_MINERAL_STOREROOM, ACCESS_MINISAT, ACCESS_NETWORK, ACCESS_CLONING, ACCESS_BRIGDOC, ACCESS_BLUESHIELD, ACCESS_BRIDGE_OFFICER, ACCESS_PSYCH)

/proc/get_all_centcom_access()
	return list(ACCESS_CENT_GENERAL, ACCESS_CENT_THUNDER, ACCESS_CENT_SPECOPS, ACCESS_CENT_MEDICAL, ACCESS_CENT_LIVING, ACCESS_CENT_STORAGE, ACCESS_CENT_TELEPORTER, ACCESS_CENT_CAPTAIN)

/proc/get_ert_access(class)
	switch(class)
		if("commander")
			return get_all_centcom_access()
		if("sec")
			return list(ACCESS_CENT_GENERAL, ACCESS_CENT_SPECOPS, ACCESS_CENT_LIVING)
		if("eng")
			return list(ACCESS_CENT_GENERAL, ACCESS_CENT_SPECOPS, ACCESS_CENT_LIVING, ACCESS_CENT_STORAGE)
		if("med")
			return list(ACCESS_CENT_GENERAL, ACCESS_CENT_SPECOPS, ACCESS_CENT_MEDICAL, ACCESS_CENT_LIVING)

/proc/get_all_ghost_access()
	return list(ACCESS_AWAY_COMMAND, ACCESS_AWAY_ENGINEERING, ACCESS_AWAY_MEDICAL, ACCESS_AWAY_SUPPLY, ACCESS_AWAY_SCIENCE, ACCESS_AWAY_MAINTENANCE, ACCESS_AWAY_GENERAL , ACCESS_AWAY_MAINT, ACCESS_AWAY_MED, ACCESS_AWAY_SEC, ACCESS_AWAY_ENGINE, ACCESS_AWAY_GENERIC1, ACCESS_AWAY_GENERIC2, ACCESS_AWAY_GENERIC3, ACCESS_AWAY_GENERIC4)

/proc/get_all_syndicate_access()
	return list(ACCESS_SYNDICATE, ACCESS_SYNDICATE_LEADER, ACCESS_SLAVER, ACCESS_BLOODCULT, ACCESS_CLOCKCULT, ACCESS_INTEQ, ACCESS_INTEQ_LEADER)

/proc/get_all_inteq_access()
	return list(ACCESS_INTEQ, ACCESS_INTEQ_LEADER)

/proc/get_region_accesses(code)
	switch(code)
		if(0)
			return get_all_accesses()
		if(1) //station general
			return list(ACCESS_KITCHEN,ACCESS_BAR, ACCESS_HYDROPONICS, ACCESS_JANITOR, ACCESS_CHAPEL_OFFICE, ACCESS_CREMATORIUM, ACCESS_LIBRARY, ACCESS_THEATRE, ACCESS_LAWYER)
		if(2) //security
			return list(ACCESS_SEC_DOORS, ACCESS_WEAPONS, ACCESS_SECURITY, ACCESS_BRIG, ACCESS_ARMORY, ACCESS_FORENSICS_LOCKERS, ACCESS_COURT, ACCESS_HOS, ACCESS_ENTER_GENPOP, ACCESS_LEAVE_GENPOP, ACCESS_BRIGDOC)
		if(3) //medbay
			return list(ACCESS_MEDICAL, ACCESS_GENETICS, ACCESS_CLONING, ACCESS_MORGUE, ACCESS_CHEMISTRY, ACCESS_VIROLOGY, ACCESS_SURGERY, ACCESS_CMO, ACCESS_PSYCH)
		if(4) //research
			return list(ACCESS_RESEARCH, ACCESS_TOX, ACCESS_TOX_STORAGE, ACCESS_GENETICS, ACCESS_ROBOTICS, ACCESS_XENOBIOLOGY, ACCESS_MINISAT, ACCESS_RD, ACCESS_NETWORK)
		if(5) //engineering and maintenance
			return list(ACCESS_CONSTRUCTION, ACCESS_MAINT_TUNNELS, ACCESS_ENGINE, ACCESS_ENGINE_EQUIP, ACCESS_EXTERNAL_AIRLOCKS, ACCESS_TECH_STORAGE, ACCESS_ATMOSPHERICS, ACCESS_TCOMSAT, ACCESS_MINISAT, ACCESS_CE)
		if(6) //supply
			return list(ACCESS_MAILSORTING, ACCESS_MINING, ACCESS_MINING_STATION, ACCESS_MINERAL_STOREROOM, ACCESS_CARGO, ACCESS_QM, ACCESS_VAULT)
		if(7) //command
			return list(ACCESS_HEADS, ACCESS_RC_ANNOUNCE, ACCESS_KEYCARD_AUTH, ACCESS_CHANGE_IDS, ACCESS_AI_UPLOAD, ACCESS_TELEPORTER, ACCESS_EVA, ACCESS_GATEWAY, ACCESS_ALL_PERSONAL_LOCKERS, ACCESS_HOP, ACCESS_CAPTAIN, ACCESS_VAULT)
		if(8) //away
			return list(ACCESS_AWAY_COMMAND, ACCESS_AWAY_ENGINEERING, ACCESS_AWAY_MEDICAL, ACCESS_AWAY_SUPPLY, ACCESS_AWAY_SCIENCE, ACCESS_AWAY_MAINTENANCE, ACCESS_AWAY_GENERAL , ACCESS_AWAY_MAINT, ACCESS_AWAY_MED, ACCESS_AWAY_SEC, ACCESS_AWAY_ENGINE, ACCESS_AWAY_GENERIC1, ACCESS_AWAY_GENERIC2, ACCESS_AWAY_GENERIC3, ACCESS_AWAY_GENERIC4)


/proc/get_region_accesses_name(code)
	switch(code)
		if(0)
			return "All"
		if(1) //station general
			return "General"
		if(2) //security
			return "Security"
		if(3) //medbay
			return "Medbay"
		if(4) //research
			return "Research"
		if(5) //engineering and maintenance
			return "Engineering"
		if(6) //supply
			return "Supply"
		if(7) //command
			return "Command"

/proc/get_access_desc(A)
	switch(A)
		if(ACCESS_CARGO)
			return "Cargo Bay"
		if(ACCESS_CARGO_BOT)
			return "Delivery Chutes"
		if(ACCESS_SECURITY)
			return "Security Equipment"
		if(ACCESS_BRIG)
			return "Holding Cells and Prisoner Management"
		if(ACCESS_COURT)
			return "Courtroom"
		if(ACCESS_FORENSICS_LOCKERS)
			return "Forensics Lockers"
		if(ACCESS_MEDICAL)
			return "Medical"
		if(ACCESS_GENETICS)
			return "Genetics Lab"
		if(ACCESS_MORGUE)
			return "Morgue"
		if(ACCESS_TOX)
			return "R&D Lab"
		if(ACCESS_TOX_STORAGE)
			return "Toxins Lab"
		if(ACCESS_CHEMISTRY)
			return "Chemistry Lab"
		if(ACCESS_RD)
			return "RD Office"
		if(ACCESS_BAR)
			return "Bar"
		if(ACCESS_JANITOR)
			return "Custodial Closet"
		if(ACCESS_ENGINE)
			return "Engineering"
		if(ACCESS_ENGINE_EQUIP)
			return "Power and Engineering Equipment"
		if(ACCESS_MAINT_TUNNELS)
			return "Maintenance"
		if(ACCESS_EXTERNAL_AIRLOCKS)
			return "External Airlocks"
		if(ACCESS_EMERGENCY_STORAGE)
			return "Emergency Storage"
		if(ACCESS_CHANGE_IDS)
			return "ID Console"
		if(ACCESS_AI_UPLOAD)
			return "AI Chambers"
		if(ACCESS_TELEPORTER)
			return "Teleporter"
		if(ACCESS_EVA)
			return "EVA"
		if(ACCESS_HEADS)
			return "Bridge and Command Equipment"
		if(ACCESS_CAPTAIN)
			return "Captain"
		if(ACCESS_ALL_PERSONAL_LOCKERS)
			return "Personal Lockers"
		if(ACCESS_CHAPEL_OFFICE)
			return "Chapel Office"
		if(ACCESS_TECH_STORAGE)
			return "Technical Storage"
		if(ACCESS_ATMOSPHERICS)
			return "Atmospherics"
		if(ACCESS_CREMATORIUM)
			return "Crematorium"
		if(ACCESS_ARMORY)
			return "Armory"
		if(ACCESS_CONSTRUCTION)
			return "Construction"
		if(ACCESS_KITCHEN)
			return "Kitchen"
		if(ACCESS_HYDROPONICS)
			return "Hydroponics"
		if(ACCESS_LIBRARY)
			return "Library"
		if(ACCESS_LAWYER)
			return "Law Office"
		if(ACCESS_ROBOTICS)
			return "Robotics"
		if(ACCESS_VIROLOGY)
			return "Virology"
		if(ACCESS_CMO)
			return "CMO Office"
		if(ACCESS_QM)
			return "Quartermaster"
		if(ACCESS_SURGERY)
			return "Surgery"
		if(ACCESS_THEATRE)
			return "Theatre"
		if(ACCESS_MANUFACTURING)
			return "Manufacturing"
		if(ACCESS_RESEARCH)
			return "Science"
		if(ACCESS_MINING)
			return "Mining"
		if(ACCESS_MINING_OFFICE)
			return "Mining Office"
		if(ACCESS_MAILSORTING)
			return "Cargo Office"
		if(ACCESS_MINT)
			return "Mint"
		if(ACCESS_MINT_VAULT)
			return "Mint Vault"
		if(ACCESS_VAULT)
			return "Main Vault"
		if(ACCESS_MINING_STATION)
			return "Mining EVA"
		if(ACCESS_XENOBIOLOGY)
			return "Xenobiology Lab"
		if(ACCESS_HOP)
			return "HoP Office"
		if(ACCESS_HOS)
			return "HoS Office"
		if(ACCESS_CE)
			return "CE Office"
		if(ACCESS_RC_ANNOUNCE)
			return "RC Announcements"
		if(ACCESS_KEYCARD_AUTH)
			return "Keycode Auth."
		if(ACCESS_TCOMSAT)
			return "Telecommunications"
		if(ACCESS_GATEWAY)
			return "Gateway"
		if(ACCESS_SEC_DOORS)
			return "Security SubDepartment Doors"
		if(ACCESS_ENTER_GENPOP)
			return "Prison Turnstile Entrance"
		if(ACCESS_LEAVE_GENPOP)
			return "Prison Turnstile Exit"
		if(ACCESS_MINERAL_STOREROOM)
			return "Mineral Storage"
		if(ACCESS_MINISAT)
			return "AI Satellite"
		if(ACCESS_WEAPONS)
			return "Weapon Permit"
		if(ACCESS_NETWORK)
			return "Network Access"
		if(ACCESS_CLONING)
			return "Cloning Room"
		if(ACCESS_BRIGDOC)
			return "Brig Physician"
		if(ACCESS_BLUESHIELD)
			return "Blueshield"
		if(ACCESS_BRIDGE_OFFICER)
			return "Bridge Officer"
		if(ACCESS_PSYCH)
			return "Psychology Office"

/proc/get_centcom_access_desc(A)
	switch(A)
		if(ACCESS_CENT_GENERAL)
			return "Code Grey"
		if(ACCESS_CENT_THUNDER)
			return "Code Yellow"
		if(ACCESS_CENT_STORAGE)
			return "Code Orange"
		if(ACCESS_CENT_LIVING)
			return "Code Green"
		if(ACCESS_CENT_MEDICAL)
			return "Code White"
		if(ACCESS_CENT_TELEPORTER)
			return "Code Blue"
		if(ACCESS_CENT_SPECOPS)
			return "Code Black"
		if(ACCESS_CENT_CAPTAIN)
			return "Code Gold"
		if(ACCESS_CENT_BAR)
			return "Code Scotch"

/proc/get_all_jobs()
	return list("Assistant","Bridge Officer", "Captain", "Blueshield", "Head of Personnel", "Bartender", "Cook", "Entertainer", "Botanist", "Quartermaster", "Cargo Technician",
				"Shaft Miner", "Clown", "Mime", "Janitor", "Curator", "Internal Affairs Agent", "Chaplain", "Chief Engineer", "Station Engineer",
				"Atmospheric Technician", "Chief Medical Officer", "Medical Doctor", "Chemist", "Geneticist", "Virologist", "Psychologist", "Paramedic",
				"Research Director", "Scientist", "Roboticist", "Expeditor", "Head of Security", "Warden", "Detective", "Security Officer", "Brig Physician", "Peacekeeper", "Prisoner", "NanoTrasen Representative", "Bouncer") //BlueMoon edit

/proc/get_all_job_icons() //For all existing HUD icons
	return get_all_jobs()

/proc/get_all_centcom_jobs()
	return list("VIP Guest","Custodian","Thunderdome Overseer","CentCom Official","Medical Officer","Death Commando","Research Officer","Special Ops Officer","Admiral","CentCom Commander","Emergency Response Team Commander","Security Response Officer","Engineer Response Officer", "Medical Response Officer","CentCom Bartender","Nuclear Waste Expert","Giant Bun Liaison") //No idea how to modularly edit a global proc

/// Gets the job title, if the job name is an alt title, locates the original title using a prebuilt cache
/proc/GetJobName(jobName)
	return SSjob.real_job_name[jobName] || "Unknown"

/obj/item/proc/get_job_name() //Used in secHUD icon generation
	if (istype(src, /obj/item/card/id/debug/bst))
		return "scrambled"
	if (istype(src, /obj/item/card/id/nri))
		return "nri"
	if (istype(src, /obj/item/card/id/nri_citizen))
		return "nri"
	if (istype(src, /obj/item/card/id/sol))
		return "sol"
	if (istype(src, /obj/item/card/id/sol_citizen))
		return "sol"
	if (istype(src, /obj/item/card/id/heresy))
		return "heresy"
	if (istype(src, /obj/item/card/id/lust))
		return "lust"
	if (istype(src, /obj/item/card/id/agony))
		return "agony"
	if (istype(src, /obj/item/card/id/muck))
		return "muck"
	if (istype(src, /obj/item/card/id/blumenland_citizen))
		return "bmland"
	if (istype(src, /obj/item/card/id/death))
		return "deathcommando"
	if (istype(src, /obj/item/card/id/syndicate) & src.icon_state == "card_black")
		var/obj/item/card/id/card = src
		if (card.assignment == initial(card.assignment))
			return "syndicate"
	if (istype(src, /obj/item/card/id/inteq) & src.icon_state == "inteq")
		var/obj/item/card/id/card = src
		if (card.assignment == initial(card.assignment))
			return "inteq"
	var/obj/item/card/id/I = GetID()
	if(!I)
		return
	return GetJobName(I.assignment)
