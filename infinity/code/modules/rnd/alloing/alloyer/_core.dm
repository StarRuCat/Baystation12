/obj/machinery/alloyer
	name = "atomic furnace"
	desc = "This is an atomic furnace.<br>It deconstruct materials and merge them, creating alloy."

	icon = 'infinity/icons/obj/rnd/alloing/alloyer.dmi'
	icon_state = "alloyer"
	var/base_icon_state

	density = 1
	anchored = 1


	var/list/metals[2] //metals to alloy
	var/list/additives = list() //like carbon in steel
	var/material/result_alloy = null
	var/alloy_temperature = 293

	var/alloing_in_progress = 0
	var/loading_materials_in_progress = 0
	var/on = 1

	var/template = "_inf.alloyer.tmpl"
	var/template_title = "Omega Materials Atomic Alloyer"

	var/ui_window = "main_menu"
	var/ui_bg = "background-color: #1d3126; background-image: url(inf_uiBasicBackground-OmegaMat.png) repeat-x"

/obj/machinery/alloyer/nt
	ui_bg = ""

/obj/machinery/alloyer/Initialize()
	. = ..()
	if(!base_icon_state) base_icon_state = icon_state

	update_icon()

#include "icon.dm"
#include "interaction.dm"
#include "ui.dm"
