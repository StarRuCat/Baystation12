
/mathrix/New(var/x, var/y, var/list/new_values = null)
	spawn(0) del(src)
	var/list/M[x]
	var/ix = 1
	while(ix <= x)
		var/list/LX[y]
		M[ix] = LX
		ix += 1

	if(new_values && istype(new_values))
		for(var/list/i in M)
			var/iy = 1
			while(iy <= y)
				i[iy] = new_values[iy]
				iy += 1
	return M

/obj/structure/mathrix_tester
	name = "mathrix tester"
	icon_state = "alien_grate"
	attack_hand(mob/user)
		. = ..()
		to_world(Start_Test())


/obj/structure/mathrix_tester/proc/Start_Test()
	var/mathrix/M = new(5,6)
	var/list/dot = list()
	var/i = 1
	while(i <= length(M))
		var/b = 1
		while(b <= length(M[i]))
			M[i][b] = rand(100, 999)
			b += 1
		dot += jointext(M[i], ", ")
		i += 1

	return dot.Join("<br>")