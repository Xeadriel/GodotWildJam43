extends AnimatedSprite
class_name Aura

onready var yang = get_parent()
onready var game = get_parent().get_parent()

var yin = null

var timer = 0

func _process(delta: float) -> void:
	if game.pause:
		return
	if timer >= 0.2:
		applyAuraEffect()
	if timer >= 5:
		queue_free()
	timer += delta

func applyAuraEffect():
	pass

func bodyEntered(body : Node):
	pass

func bodyExited(body : Node):
	pass


