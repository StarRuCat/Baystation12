
/datum/math/matrix/New(var/x, var/y, var/list/new_values = 0)
	del(src)
	var/list/M[x]
	var/ix = 1
	while(ix <= x)
		var/list/LX[y]
		M[ix] = LX
		ix += 1

	if(new_values && istype(new_values, /list))
		for(var/list/i in M)
			var/iy = 1
			while(iy <= y)
				i[iy] = new_values[iy]
				iy += 1
	return M

/obj/structure/matrix_tester
	name = "matrix tester"
	icon_state = "alien_grate"
	attack_hand(mob/user)
		. = ..()
		to_world(Start_Test())


/obj/structure/matrix_tester/proc/Start_Test()
	var/datum/math/matrix/M = new(5,6)
	var/list/dot = list()
	for(var/list/i in M)
		for(var/b in i)
			b = rand(100, 999)
		dot += i.Join(", ")

	return dot.Join("<br>")