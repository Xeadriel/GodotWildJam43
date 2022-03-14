extends Node2D

var selected = null

func _unhandled_input(event: InputEvent) -> void:
	#selection
	if event.is_action_pressed("leftClick"):
		deselect()
		var shapes = get_world_2d().direct_space_state.intersect_point(get_global_mouse_position(), 32, [], 0x7FFFFFFF, true, true) # The last 'true' enables Area2D intersections, previous four values are all defaults
		var idComp = -1
		var index = 0
		#in case there is a collision that has no "onClick" function
		while(!shapes.empty()):
			#search for index with biggest id
			#aka newest object aka object thats on top
			for i in range(0, shapes.size()):
				if shapes[i]["collider_id"] > idComp:
					idComp = shapes[i]["collider_id"]
					index = i
				if shapes[i]["collider"] is PC:
					index = i
					break

			if shapes[index]["collider"].has_method("select"):
				selected = shapes[index]["collider"]
				selected.select()
				break
			else:
				shapes.remove(index)


func deselect():
	if selected != null:
		selected.deselect()
	selected = null
