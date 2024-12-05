//Added by Jack Rost! (and lucky now :3)
/obj/item/trash
	icon = 'icons/obj/janitor.dmi'
	lefthand_file = 'icons/mob/inhands/misc/food_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/misc/food_righthand.dmi'
	desc = "This is rubbish."
	w_class = WEIGHT_CLASS_TINY
	resistance_flags = FLAMMABLE

/obj/item/trash/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/trash)

/obj/item/trash/sfseeds
	name = "\improper Old Glory sunflower seeds"
	icon_state = "sfseeds"
	icon = 'modular_splurt/icons/obj/janitor.dmi'
