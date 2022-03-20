extends KinematicBody2D
class_name PC

onready var game = get_parent()

var selected = false
var path =  []

const MAXSPEED = 3
var speed = 3
var spellPot = []
var spellToBeCast = []

var hp = 100

onready var previews = []

enum {FORCE, FIRE, EARTH, PSI, WATER, AIR}

onready var nav = get_parent().get_node("Navigation2D")
onready var hpBar = $HPBar


func _ready() -> void:
	pass


func _process(delta: float) -> void:
	if not game.pause:
		moveTowardsPoint()
		checkIfNextPointReached()
		castSpell()

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("rightClick"):
		if not selected or not spellPot.empty():
			return
		spellToBeCast = []
		spellPot = []
		for preview in previews:
			preview.visible = false
		path = nav.get_simple_path(position, event.position)

func castSpell():
	pass

func setSpell(pos):
	for preview in previews:
		preview.visible = false
	spellToBeCast = [spellPot, pos]
	spellPot = []

func water(waterStrength):
	hp = hp + waterStrength *5
	hpBar.value = hp
	if hp > 100:
		hp = 100

func takeDamage(dmg):
	hp -= dmg
	hpBar.value = hp
	if hp <= 0:
		GlobalScope.switchToMainMenu()

func speed(waterStrength):
	speed = 3 + MAXSPEED* waterStrength

func select():
	selected = true

func deselect():
	selected = false

func stopNavigation():
	path = []

func moveTowardsPoint():
	if path.empty():
		return
	var direction = position.direction_to(path[0])
	position += speed * direction

func checkIfNextPointReached():
	if path.empty():
		return
	if compareFloats(position.x, path[0].x, speed-1) == 1 and compareFloats(position.y, path[0].y, speed-1) == 1:
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
