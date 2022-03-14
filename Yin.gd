extends PC
class_name Yin

onready var conePreview = $ConePreview

func _ready() -> void:
	pass

func _process(delta: float) -> void:
	if not spellPot.empty():
		game.deselect()

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

		if force > 0 and force <= 3 and fire == 0 and earth == 0:
			conePreview.visible = true
		else:
			conePreview.visible = false


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("rightClick"):
		if not spellPot.empty():
			spellPot = []
	if event.is_action_pressed("leftClick"):
		if not spellPot.empty():
			castSpell(event.position)
			spellPot = []
	if event.is_action_pressed("force"):
		if spellPot.size() == 3:
			spellPot.pop_front()
		spellPot.append(FORCE)

	if event.is_action_pressed("fire"):
		if spellPot.size() ==3:
			spellPot.pop_front()
		spellPot.append(FIRE)

	if event.is_action_pressed("earth"):
		if spellPot.size() ==3:
			spellPot.pop_front()
		spellPot.append(EARTH)

func castSpell(position):
	conePreview.visible = false
