extends Node2D
class_name ForcePush

onready var area = $Area2D
onready var areaShape = $Area2D/CollisionShape2D
onready var game = get_parent()

var forceStrength = 0
var fireStrength = 0

var timer = 0


func _process(delta: float) -> void:
	if game.pause:
		return
	if timer >= 0.00001:
		var bodies = area.get_overlapping_bodies()
		
		for body in bodies:
			if (body is Enemy):
				body.force(Vector2.LEFT.rotated(rotation), forceStrength, fireStrength)
		areaShape.disabled = true
	
	if timer >= 1.5:
		queue_free()
	timer+=delta
