/obj/machinery/alloyer
	var/template = "_inf.alloyer.tmpl"
	var/template_title = "Omega Materials Atomic Alloyer"

	var/ui_window = "main_menu"
	var/ui_win_data = list()

/obj/machinery/alloyer/proc/generate_win_data()
	if(materials.len)
		var/material/material1
		var/material/material2
		if(materials[1]) material1 = materials[1]
		if(materials.len >= 2 && materials[2]) material2 = materials[2]
		if(!material1)
			ui_win_data["first_metal"] = "No material found"
		else
			ui_win_data["first_metal"] = generate_material_data(material1)
		if(!material2)
			ui_win_data["second_metal"] = "No material found"
		else
			ui_win_data["second_metal"] = generate_material_data(material2)

		if(!additives)
			ui_win_data["additives"] = "No beaker inserted"
		else
			ui_win_data["additives"] = generate_additives_data(additives)

/obj/machinery/alloyer/proc/generate_material_data(var/material/M)
	return "data"
/obj/machinery/alloyer/proc/generate_additives_data(var/obj/item/weapon/reagent_containers/glass/beaker/B)
	return "data"
/obj/machinery/alloyer/proc/get_ui_data()
	. = list()
	.["ui_window"]		=	ui_window
	.["ui_win_data"]	=	ui_win_data

/obj/machinery/alloyer/ui_interact(mob/user, ui_key = "main", datum/nanoui/ui = null, force_open = 1, var/master_ui = null, var/datum/topic_state/state = GLOB.default_state)
	generate_win_data()
	var/data = list()
	data = get_ui_data()
	ui = SSnano.try_update_ui(user, src, ui_key, ui, data, force_open)
	if (!ui)
		ui = new(user, src, ui_key, template, template_title, 800, 600)
		ui.set_initial_data(data)
		ui.open()

/obj/machinery/alloyer/OnTopic(user, href_list)
	if(on)
		if(istext(href_list["window"]))
			ui_window = href_list["window"]
			. = TOPIC_REFRESH

		if(href_list["emergency_shutdown"])
			shutmedown()
			. = TOPIC_REFRESH
	else
		if(href_list["bootmeup"])
			rebootmeup()
			. = TOPIC_REFRESH
	update_icon()

/obj/machinery/alloyer/proc/rebootmeup()
	on = 1
	ui_window = "main_menu"
/obj/machinery/alloyer/proc/shutmedown()
	on = 0
	ui_window = "reboot"