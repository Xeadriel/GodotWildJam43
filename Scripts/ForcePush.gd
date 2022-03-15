extends Node2D
class_name ForcePush

onready var area = $Area2D
onready var areaShape = $Area2D/CollisionShape2D

var forceStrength = 0
var fireStrength = 0

var timer = 0

func _process(delta: float) -> void:
	if timer >= 0.001:
		var bodies = area.get_overlapping_bodies()
		
		for body in bodies:
			if not (body is PC):
				body.force(global_position, forceStrength, fireStrength)
		areaShape.disabled = true
	
	if timer >= 1.5:
		queue_free()
	timer+=delta
