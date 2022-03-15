extends PC
class_name Yang



func _ready() -> void:
	pass


func _process(delta: float) -> void:
	if not spellPot.empty():
		game.deselect()

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

func setSpell(position):
	print(spellPot)
