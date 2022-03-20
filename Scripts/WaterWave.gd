extends AnimatedSprite
class_name WaterWave

onready var area = $Area2D
onready var areaShape = $Area2D/CollisionShape2D

var timer = 0
var direction = Vector2.ONE

onready var game = get_parent()

func _process(delta: float) -> void:
	if game.pause:
		return
	if timer >= 0.001:
		var bodies = area.get_overlapping_bodies()
		
		for body in bodies:
			if (body is Enemy):
				body.waterWave(direction)
		
	if timer >= 1.5:
		queue_free()
	timer+=delta

