extends Node2D

var selected = true

var path =  []

const SPEED = 5

onready var nav = get_parent().get_node("Navigation2D")


func _ready() -> void:
	pass


func _process(delta: float) -> void:
	moveTowardsPoint()
	checkIfNextPointReached()

func _unhandled_input(event: InputEvent) -> void:
	if not selected:
		return
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_RIGHT and event.pressed:
			path = nav.get_simple_path(global_position, event.global_position)

func moveTowardsPoint():
	if not path.empty():
		return
	var direction = global_position.direction_to(path[0])
	global_position += SPEED * direction

func checkIfNextPointReached():
	pass


func compFloats(a, b, epsilon):
	if a > b:
		pass
