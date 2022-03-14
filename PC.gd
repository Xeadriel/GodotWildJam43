extends KinematicBody2D
class_name PC

var selected = false
var paused = false
var path =  []

const SPEED = 3

onready var nav = get_parent().get_node("Navigation2D")


func _ready() -> void:
	pass


func _process(delta: float) -> void:
	if not paused:
		moveTowardsPoint()
		checkIfNextPointReached()

func _unhandled_input(event: InputEvent) -> void:
	if not selected:
		return
	if event.is_action_pressed("rightClick"):
		path = nav.get_simple_path(position, event.position)

func select():
	selected = true

func deselect():
	selected = false

func moveTowardsPoint():
	if path.empty():
		return
	var direction = position.direction_to(path[0])
	position += SPEED * direction

func checkIfNextPointReached():
	if path.empty():
		return
	if compareFloats(position.x, path[0].x, SPEED-1) == 1 and compareFloats(position.y, path[0].y, SPEED-1) == 1:
		path.remove(0)

#0 = f < d; 1 = equal; 2 = f > d
func compareFloats(f : float, d : float, epsilon : float):

	var high = float(d + epsilon)
	var low = float(d - epsilon)

	if f < high and f > low:
		return 1

	if f > high:
		return 2

	if f < low:
		return 0
