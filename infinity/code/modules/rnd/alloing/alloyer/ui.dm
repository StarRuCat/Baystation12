/obj/machinery/alloyer
	var/template = "_inf.alloyer.tmpl"
	var/template_title = "Omega Materials Atomic Alloyer"

	var/ui_window = "main_menu"
	var/ui_win_data = list()

/obj/machinery/alloyer/proc/generate_win_data()
	if(!metals[1]) ui_win_data["first_metal"] = "No metal found"
	if(!metals[2]) ui_win_data["second_metal"] = "No metal found"
/obj/machinery/alloyer/proc/get_ui_data()
	. = list()
	.["ui_window"]		=	ui_window
	.["ui_win_data"]	=	ui_win_data

/obj/machinery/alloyer/ui_interact(mob/user, ui_key = "main", datum/nanoui/ui = null, force_open = 1, var/master_ui = null, var/datum/topic_state/state = GLOB.default_state)
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
			on = 0
	else
		if(href_list["reboot"])
			reboot()

	update_icon()

/obj/machinery/alloyer/proc/reboot()