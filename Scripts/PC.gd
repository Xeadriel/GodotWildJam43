extends KinematicBody2D
class_name PC

onready var game = get_parent()

var selected = false
var paused = false
var path =  []

const SPEED = 3
var spellPot = []
var spellToBeCast = []

enum {FORCE, FIRE, EARTH, PSI, WATER, AIR}

onready var nav = get_parent().get_node("Navigation2D")


func _ready() -> void:
	pass


func _process(delta: float) -> void:
	if not paused:
		moveTowardsPoint()
		checkIfNextPointReached()
		castSpell()

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("rightClick"):
		if not selected:
			return
		spellToBeCast = []
		spellPot = []
		path = nav.get_simple_path(position, event.position)

func castSpell():
	pass

func setSpell(pos):
	pass

func select():
	selected = true

func deselect():
	selected = false

func togglePause():
	paused = !paused

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
