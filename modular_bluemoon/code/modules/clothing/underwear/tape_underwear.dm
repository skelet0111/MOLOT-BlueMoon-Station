/datum/gear/backpack/black_tape
	name = "Black Sticky Tape"
	path = /obj/item/stack/sticky_tape/black

/obj/item/clothing/underwear/shirt/top/black_tape
	name = "Black Sticky Tape Top"
	desc = "Идеальна для закрытия протечек."
	icon = 'modular_bluemoon/icons/obj/clothing/tape_underwear.dmi'
	mob_overlay_icon = 'modular_bluemoon/icons/mob/clothing/tape_underwear.dmi'
	icon_state = "tape_breasts"
	body_parts_covered = 0
	mutantrace_variation = STYLE_DIGITIGRADE|STYLE_NO_ANTHRO_ICON
	can_toggle = TRUE
	var/alt_pos = 0 //"cross" and "plus" styles

/obj/item/clothing/underwear/shirt/top/black_tape/examine(mob/user)
	. = ..()
	. += span_notice("Alt-Click to change wearing style.")

/obj/item/clothing/underwear/shirt/top/black_tape/AltClick(mob/user)
	. = ..()
	if(!ishuman(user) || !user.canUseTopic(src, BE_CLOSE, ismonkey(user)))
		return
	alt_pos = !alt_pos
	update_icon()

/obj/item/clothing/underwear/shirt/top/black_tape/proc/update_sprite_visibility(datum/source, obj/item/I)
	/*
	Breasts tape underwear has a unique variable set of sprites depending on user's breast size and visibility.
	Its sprite layer must be completely cut when breasts are hidden, otherwise unwanted sprite elements will be visible.
	*/
	var/mob/living/carbon/human/H = source
	//var/obj/item/organ/genital/breasts/B = locate(/obj/item/organ/genital/breasts) in H.internal_organs
	var/obj/item/organ/genital/breasts/B = H.getorganslot(ORGAN_SLOT_BREASTS)
	if(B?.is_exposed() || H.is_chest_exposed())
		H.update_inv_w_shirt()
	else if(!HAS_TRAIT(H, TRAIT_HUMAN_NO_RENDER))
		H.remove_overlay(SHIRT_LAYER)


/obj/item/clothing/underwear/shirt/top/black_tape/update_icon_state()
	. = ..()
	if(current_equipped_slot == ITEM_SLOT_SHIRT && istype(loc, /mob/living/carbon/human))
		var/mob/living/carbon/human/H = loc
		var/obj/item/organ/genital/breasts/B = H.getorganslot(ORGAN_SLOT_BREASTS)
		icon_state = "[initial(icon_state)]_[B?.size || 0][alt_pos ? "_alt" : ""]"
		H.update_inv_w_shirt() //I-size breasts and bigger have minor incorrect sprite overlay. Sort of global error. Not my mistake nor my problem.
		//update_slot_icon()
		H.update_body() //updating tape style on mob
	else
		icon_state = "[initial(icon_state)][alt_pos ? "_alt" : ""]"

/obj/item/clothing/underwear/shirt/top/black_tape/equipped(mob/user, slot)
	. = ..()
	if(slot == ITEM_SLOT_SHIRT)
		var/mob/living/carbon/human/H = user
		RegisterSignal(H, COMSIG_MOB_ITEM_EQUIPPED,  PROC_REF(update_sprite_visibility))
		RegisterSignal(H, COMSIG_MOB_UNEQUIPPED_ITEM,  PROC_REF(update_sprite_visibility))
		update_icon()
		H.handle_post_sex(5, null, H)

/obj/item/clothing/underwear/shirt/top/black_tape/dropped(mob/user)
	. = ..()
	if(current_equipped_slot == ITEM_SLOT_SHIRT)
		var/mob/living/carbon/human/H = user
		UnregisterSignal(H, list(COMSIG_MOB_ITEM_EQUIPPED, COMSIG_MOB_UNEQUIPPED_ITEM))
		update_icon()
		playsound(loc, 'sound/items/poster_ripped.ogg', 20, 1)
		H.handle_post_sex(5, null, H)
		H.moan()

/obj/item/clothing/underwear/briefs/black_tape
	name = "Black Sticky Tape Groin"
	desc = "Идеальна для закрытия протечек."
	icon = 'modular_bluemoon/icons/obj/clothing/tape_underwear.dmi'
	mob_overlay_icon = 'modular_bluemoon/icons/mob/clothing/tape_underwear.dmi'
	icon_state = "tape_groin"
	body_parts_covered = 0 //thicc thigs and ass must not be hidden.
	mutantrace_variation = STYLE_DIGITIGRADE|STYLE_NO_ANTHRO_ICON

/obj/item/clothing/underwear/briefs/black_tape/update_icon_state()
	. = ..()
	if(current_equipped_slot == ITEM_SLOT_UNDERWEAR && istype(loc, /mob/living/carbon/human))
		var/mob/living/carbon/human/H = loc
		icon_state = "[initial(icon_state)][H.has_penis() ? "_buldge" : ""]"
		H.update_inv_w_underwear()
	else
		icon_state = "[initial(icon_state)]"

/obj/item/clothing/underwear/briefs/black_tape/equipped(mob/user, slot)
	. = ..()
	if(slot == ITEM_SLOT_UNDERWEAR)
		update_icon()
		var/mob/living/carbon/human/H = user
		H.handle_post_sex(5, null, H)
		//Imitating genital coverage. Thigs and ass will still be visible. Exactly what we need.
		var/obj/item/organ/genital/penis/P = H.getorganslot(ORGAN_SLOT_PENIS)
		P?.toggle_visibility(GEN_VISIBLE_NEVER) //How 100+ penis can be hidden with a piece of tape? Bluespace anomaly. Like all other underwear.
		var/obj/item/organ/genital/testicles/T = H.getorganslot(ORGAN_SLOT_TESTICLES)
		T?.toggle_visibility(GEN_VISIBLE_NEVER)
		var/obj/item/organ/genital/vagina/V = H.getorganslot(ORGAN_SLOT_VAGINA)
		V?.toggle_visibility(GEN_VISIBLE_NEVER)
		var/obj/item/organ/genital/anus/A = H.getorganslot(ORGAN_SLOT_ANUS)
		A?.toggle_visibility(GEN_VISIBLE_NEVER)

/obj/item/clothing/underwear/briefs/black_tape/dropped(mob/user)
	. = ..()
	if(current_equipped_slot == ITEM_SLOT_UNDERWEAR)
		update_icon()
		var/mob/living/carbon/human/H = user
		playsound(loc, 'sound/items/poster_ripped.ogg', 20, 1)
		H.handle_post_sex(5, null, H)
		H.moan()
		//Uncovering things.
		var/obj/item/organ/genital/penis/P = H.getorganslot(ORGAN_SLOT_PENIS)
		P?.toggle_visibility(GEN_VISIBLE_NO_UNDIES)
		var/obj/item/organ/genital/testicles/T = H.getorganslot(ORGAN_SLOT_TESTICLES)
		T?.toggle_visibility(GEN_VISIBLE_NO_UNDIES)
		var/obj/item/organ/genital/vagina/V = H.getorganslot(ORGAN_SLOT_VAGINA)
		V?.toggle_visibility(GEN_VISIBLE_NO_UNDIES)
		var/obj/item/organ/genital/anus/A = H.getorganslot(ORGAN_SLOT_ANUS)
		A?.toggle_visibility(GEN_VISIBLE_NO_UNDIES)
