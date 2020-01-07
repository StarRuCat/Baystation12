/obj/machinery/alloyer
	var/template = "_inf.alloyer.tmpl"
	var/template_title = "Omega Materials Atomic Alloyer"

	var/ui_window = "main_menu"
	var/list/ui_win_data = list()
	var/list/ui_win_preview = list()

/obj/machinery/alloyer/proc/generate_win_data()
	if(materials.len)
		var/obj/item/stack/material/material1
		var/obj/item/stack/material/material2
		materials[1] ? (material1 = materials[1]) : null
		(materials.len >= 2 && materials[2]) ? (material2 = materials[2]) : null
		if(!material1)
			ui_win_data["first_metal"] = "No material found"
		else
			ui_win_data["first_metal"] = generate_material_data(material1)
		if(!material2)
			ui_win_data["second_metal"] = "No material found"
		else
			ui_win_data["second_metal"] = ""

	if(!additives)
		ui_win_data["additives"] = "No beaker inserted"
	else
		ui_win_data["additives"] = generate_additives_data(additives)

/obj/machinery/alloyer/proc/generate_win_previews()
	if(materials.len)
		if(materials[1])
			var/obj/item/stack/material/material1 = materials[1]
			ui_win_preview["first_metal"] = generate_material_preview(material1)
		if(materials.len >= 2 && materials[2])
			var/obj/item/stack/material/material2
			ui_win_preview["second_metal"] = generate_material_preview(material2)

/obj/machinery/alloyer/proc/generate_material_preview(var/obj/item/stack/material/STACK)
	var/list/dot = list("<img src=\"inf.material.png\" height=200></img>", "name = [STACK.material.name]")
	dot += STACK.material.lore_text
	return dot.Join("<br>")

/obj/machinery/alloyer/proc/generate_material_data(var/obj/item/stack/material/STACK)
	if(STACK.material)
		var/material/M = STACK.material
		var/list/mdata = list("<img src=\"inf.material.png\" height=400></img>", "<h1>[M.name]</h1>")
		if(M.brute_armor)				mdata += "Physical durability: [M.brute_armor]"
		if(M.burn_armor)				mdata += "Infusibility: [M.brute_armor]"
		if(M.integrity)					mdata += "Structure durability: [M.integrity]"
		if(M.explosion_resistance)		mdata += "Explosion Resistance: [M.explosion_resistance]"
		if(istype(M, /material/alloy))
			var/material/alloy/mm = M
			mdata += "Difficulty of alloy: [mm.alloy_difficulty_level]"


		return mdata.Join("<br>")
	return "data"

/obj/machinery/alloyer/proc/generate_additives_data(var/obj/item/weapon/reagent_containers/glass/beaker/B)
	return "data"

/obj/machinery/alloyer/proc/get_ui_data()
	generate_win_data()
	generate_win_previews()
	. = list()
	.["ui_window"]		=	ui_window
	.["ui_win_data"]	=	ui_win_data
	.["ui_win_preview"]	=	ui_win_preview

/obj/machinery/alloyer/ui_interact(mob/user, ui_key = "main", datum/nanoui/ui = null, force_open = 1, var/master_ui = null, var/datum/topic_state/state = GLOB.default_state)
	var/data = list()
	data = get_ui_data()
	ui = SSnano.try_update_ui(user, src, ui_key, ui, data, force_open)
	if(!ui)
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
		if(href_list["eject_material"])
			eject_material(href_list["eject_material"])
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

/obj/machinery/alloyer/proc/eject_material(var/)