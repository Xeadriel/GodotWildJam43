extends PC
class_name Yin

onready var conePreview = $ConePreview
onready var circlePreview = $CirclePreview


export var forcePushSpawner : PackedScene
export var earthAOESpawner : PackedScene
export var fireBallSpawner : PackedScene
export var magmaFistSpawner : PackedScene

func _ready() -> void:
	previews = [conePreview, circlePreview]

func _process(delta: float) -> void:
		var force = 0
		var fire = 0
		var earth = 0
		
		for spell in spellPot:
			if spell == FORCE:
				force += 1
			if spell == FIRE:
				fire += 1
			if spell == EARTH:
				earth += 1
		
		if force == 1 and fire == 1 and earth == 1:
			conePreview.visible = false
			circlePreview.visible = false
		elif force > 0 and force <= 3 and fire >= 0 and earth == 0:
			conePreview.visible = true
		elif  force >= 0 and fire >= 0 and earth > 0 and earth <= 3:
			circlePreview.visible = true
		else:
			conePreview.visible = false
			circlePreview.visible = false



func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("rightClick"):
		if not spellPot.empty():
			spellPot = []
	if event.is_action_pressed("leftClick"):
		if not spellPot.empty():
			setSpell(event.position)
			spellPot = []
	if event.is_action_pressed("force"):
		if spellPot.size() == 3:
			spellPot.pop_front()
		spellPot.append(FORCE)
		
	if event.is_action_pressed("fire"):
		if spellPot.size() == 3:
			spellPot.pop_front()
		spellPot.append(FIRE)
		
	if event.is_action_pressed("earth"):
		if spellPot.size() == 3:
			spellPot.pop_front()
		spellPot.append(EARTH)



func castSpell():
	if spellToBeCast.empty():
		return
	var force = 0
	var fire = 0
	var earth = 0
	
	var spells = spellToBeCast[0]
	var pos = spellToBeCast[1]
	spellToBeCast = []
	
	for spell in spells:
		if spell == FORCE:
			force += 1
		if spell == FIRE:
			fire += 1
		if spell == EARTH:
			earth += 1

	if force > 0 and force <= 3 and fire >= 0 and earth == 0: #force push with or without fire
		var forcePush  = forcePushSpawner.instance()
		forcePush.forceStrength = force
		forcePush.fireStrength = fire
		forcePush.global_position = global_position
		forcePush.rotation = global_position.angle_to_point(pos)
		game.add_child(forcePush)
	elif  ((force == 0 and fire >= 0 and earth > 0 and earth <= 3) #earth with or without addons
			or (force >= 0 and fire == 0 and earth > 0 and earth <= 3)): 
		var earthAOE  = earthAOESpawner.instance()
		earthAOE.forceStrength = force
		earthAOE.fireStrength = fire
		earthAOE.earthStrength = earth
		earthAOE.position = pos
		game.add_child(earthAOE)
	elif (force == 0 and fire > 0 and fire <= 3 and earth == 0): #fireball
		var fireBall  = fireBallSpawner.instance()
		fireBall.fireStrength = fire
		var direction = global_position.direction_to(pos)
		fireBall.direction = direction
		fireBall.global_position = global_position + direction * 10
		game.add_child(fireBall)
	elif (force == 1 and fire == 1 and earth == 1): #magmafist
		var magmafist  = magmaFistSpawner.instance()
		var direction = global_position.direction_to(pos)
		magmafist.direction = direction
		magmafist.global_position = global_position + direction * 10
		game.add_child(magmafist)
