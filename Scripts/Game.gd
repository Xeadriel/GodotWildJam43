extends Node2D

var selected = null

enum {FORCE, FIRE, EARTH, PSI, WATER, AIR}

var pause = false

onready var yang = $Yang
onready var yin = $Yin

var timer = 0
export var slimeSpawner : PackedScene

func _process(delta: float) -> void:
	timer += delta
	if timer >= 4 and not pause:
		spawnSlime()
		timer = 0

func spawnSlime():
	var slime = slimeSpawner.instance()
	slime.global_position = Vector2(450, 50)
	add_child(slime)

func _unhandled_input(event: InputEvent) -> void:
		#pausing
	if event.is_action_pressed("pause"):
		pause = !pause
	#selection
	if event.is_action_pressed("selectYin"):
		yang.deselect()
		yin.select()
		selected = yin
	if event.is_action_pressed("selectYang"):
		yin.deselect()
		yang.select()
		selected = yang
	if event.is_action_pressed("leftClick"):
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
					index = null
				if not shapes[i]["collider"] is PC:
					continue
				if shapes[i]["collider"] is PC:
					index = i
					break
			if index == null:
				return
			if shapes.size() < index:
				return
			if shapes[index]["collider"].has_method("select"):
				deselect()
				selected = shapes[index]["collider"]
				selected.select()
				break
			else:
				shapes.remove(index)


func deselect():
	if selected != null:
		selected.deselect()
	selected = null
