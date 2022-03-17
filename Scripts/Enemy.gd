extends KinematicBody2D
class_name Enemy

export var hp = 100

var burnDamage = 0
var burnTimer = 0
var burnCount = 0

var sheepTimer = 0
var sheepDuration = 0

var currentTarget = null
var path = []
var pushpoints = []

export var damage = 10
export var speed = 2

onready var sheep = $Sheep
onready var game = get_parent()
onready var nav = get_parent().get_node("Navigation2D")
onready var hpBar = $HPBar

func lookForClosestPC():
	if global_position.distance_to(game.yang.global_position) <= global_position.distance_to(game.yin.global_position):
		currentTarget = game.yang
		path = (Array(nav.get_simple_path(global_position, currentTarget.global_position)))
	else:
		currentTarget = game.yin
		path = (Array(nav.get_simple_path(global_position, currentTarget.global_position)))
		

#move to target or shoot at target
func targetCurrent():
	moveTowardsPoint()

func _process(delta: float) -> void:
	if not game.pause:
		burn(delta)
		sheep(delta)
		getPushed()
		
		if not sheep.visible:
			if pushpoints.empty():
				targetCurrent()
			lookForClosestPC()
			checkIfNextPointReached()



func force(direction : Vector2, forceStrength, fireStrength):
	var pushDirection = direction* forceStrength* 30
	pushpoints.push_front(global_position + pushDirection)
	
	applyBurn(fireStrength*5)

func fire(fireStrength):
	takeDamage(15*fireStrength)
	
	applyBurn(5*fireStrength)

func earth(origin : Vector2, forceStrength, fireStrength, earthStrength):
	if forceStrength > 0:
		force(origin.direction_to(global_position), forceStrength, fireStrength)
	else:
		applyBurn(fireStrength*5)
	
	takeDamage(10*earthStrength)

func magmaFist(direction):
	pushpoints.push_front(global_position + direction* 20)
	
	takeDamage(25)
	applyBurn(5)

func psi(psiStrength):
	sheepTimer = 0
	sheepDuration = psiStrength * 0.5

func air(pos, airStrength):
	for i in range(0, airStrength*4):
		pushpoints.push_front(pos+ (Vector2(i+1,i+1)).rotated(i))

func waterWave(direction):
	pushpoints.push_front(global_position + direction * 10)

func sheep(delta):
	if sheepDuration > 0 and sheepTimer < sheepDuration:
		sheep.visible = true
		sheepTimer += delta
	else:
		sheepDuration = 0
		sheepTimer = 0
		sheep.visible = false

func applyBurn(dmg):
	burnDamage = dmg
	burnCount = 5

func getPushed():
	if not pushpoints.empty():
		var direction = position.direction_to(pushpoints[0])
		position += speed * direction
		
		if compareFloats(position.x, pushpoints[0].x, speed-1) == 1 and compareFloats(position.y, pushpoints[0].y, speed-1) == 1:
			pushpoints.remove(0)

func burn(delta):
	if burnDamage > 0 and burnCount > 0:
		if burnTimer >= 0.2:
			takeDamage(burnDamage)
			burnTimer = 0
			burnCount -= 1
		burnTimer += delta
	else:
		burnDamage = 0
		burnCount = 0
		burnTimer = 0

func takeDamage(dmg):
	hp -= dmg
	hpBar.value = hp
	if hp <= 0:
		die()

func die():
	queue_free()

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
