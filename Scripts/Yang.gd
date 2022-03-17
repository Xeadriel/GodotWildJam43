extends PC
class_name Yang

export var psiBallSpawner : PackedScene
export var waterBallSpawner : PackedScene
export var antiProjectileSpawner : PackedScene
export var tornadoSpawner : PackedScene
export var healAuraSpawner : PackedScene
export var speedAuraSpawner : PackedScene
export var waterWaveSpawner : PackedScene

onready var circlePreview = $CirclePreview
onready var waterWavePreview = $WaterWavePreview

func _ready() -> void:
	previews = [circlePreview, waterWavePreview]


func _process(delta: float) -> void:
		var psi = 0
		var water = 0
		var air = 0
		
		for spell in spellPot:
			if spell == PSI:
				psi += 1
			if spell == WATER:
				water += 1
			if spell == AIR:
				air += 1
		
		if psi == 0 and water == 0 and  air >0 and air <=3:
			circlePreview.visible = true
		elif psi == 1 and water == 1 and air == 1:
			waterWavePreview.visible = true
		else:
			waterWavePreview.visible = false
			circlePreview.visible = false


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("rightClick"):
		if not spellPot.empty():
			spellPot = []
	if event.is_action_pressed("leftClick"):
		if not spellPot.empty():
			setSpell(event.position)
			spellPot = []
	if event.is_action_pressed("psi"):
		if spellPot.size() ==3:
			spellPot.pop_front()
		spellPot.append(PSI)

	if event.is_action_pressed("water"):
		if spellPot.size() ==3:
			spellPot.pop_front()
		spellPot.append(WATER)

	if event.is_action_pressed("air"):
		if spellPot.size() ==3:
			spellPot.pop_front()
		spellPot.append(AIR)

func castSpell():
	if spellToBeCast.empty():
		return
	var psi = 0
	var water = 0
	var air = 0
	
	var spells = spellToBeCast[0]
	var pos = spellToBeCast[1]
	spellToBeCast = []
	
	for spell in spells:
		if spell == PSI:
			psi += 1
		if spell == WATER:
			water += 1
		if spell == AIR:
			air += 1
	
	if psi == 1 and water == 1 and air == 1:
		var waterWave  = waterWaveSpawner.instance()
		waterWave.direction = global_position.direction_to(pos)
		waterWave.rotation = global_position.angle_to_point(pos)
		waterWave.global_position = pos
		game.add_child(waterWave)
	elif psi > 0 and water == 0 and air == 0:
		var psiBall  = psiBallSpawner.instance()
		psiBall.psiStrength = psi
		psiBall.direction = global_position.direction_to(pos)
		psiBall.global_position = global_position
		game.add_child(psiBall)
	elif psi == 0 and water > 0  and air == 0:
		var waterBall  = waterBallSpawner.instance()
		waterBall.waterStrength = water
		waterBall.direction = global_position.direction_to(pos)
		waterBall.global_position = global_position + waterBall.direction*30
		game.add_child(waterBall)
	elif psi == 0 and water == 0 and air > 0:
		var tornado  = tornadoSpawner.instance()
		tornado.airStrength = air
		tornado.global_position = pos
		game.add_child(tornado)
	elif psi > 0 and water == 0 and air > 0:
		var antiProjectile  = antiProjectileSpawner.instance()
		antiProjectile.scale = Vector2(1 + 0.2 *(psi+air-2), 1 + 1 *(psi+air-2))
		antiProjectile.direction = global_position.direction_to(pos)
		antiProjectile.global_position = global_position + antiProjectile.direction* 20
		antiProjectile.rotation = (global_position.angle_to_point(global_position + antiProjectile.direction* 21))
		game.add_child(antiProjectile)
	elif psi > 0 and water > 0 and air == 0:
		var healAura  = healAuraSpawner.instance()
		healAura.waterStrength = water
		healAura.psiStrength = psi
		add_child(healAura)
	elif psi == 0 and water > 0 and air > 0:
		var speedAura = speedAuraSpawner.instance()
		speedAura.waterStrength = water
		speedAura.airStrength = air
		add_child(speedAura)
