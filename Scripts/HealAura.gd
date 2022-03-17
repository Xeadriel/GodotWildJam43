extends Aura
class_name HealAura

onready var area = $Area2D

var psiStrength = 0
var waterStrength = 0

func applyAuraEffect():
	yang.water(waterStrength)
	if yin != null:
		yin.water(waterStrength)

func bodyEntered(body : Node):
	if body is Yin:
		yin = body

func bodyExited(body : Node):
	if body is Yin:
		yin = null
