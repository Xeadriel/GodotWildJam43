extends Aura
class_name SpeedAura

onready var area = $Area2D

var waterStrength = 0
var airStrength = 0

func applyAuraEffect():
	yang.speed(waterStrength)
	if yin != null:
		yin.speed(waterStrength)

func bodyEntered(body : Node):
	if body is Yin:
		yin = body

func bodyExited(body : Node):
	if body is Yin:
		yin.speed = 3
		yin = null

func _notification(what):
	if what == NOTIFICATION_PREDELETE:
		yang.speed(0)
		if yin != null:
			yin.speed(0)
