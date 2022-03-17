extends AnimatedSprite
class_name Tornado

onready var area = $Area2D
onready var areaShape = $Area2D/CollisionShape2D
onready var game = get_parent()

var airStrength = 0

var timer = 0

func _process(delta: float) -> void:
	if game.pause:
		return
	if timer >= 0.001:
		var bodies = area.get_overlapping_bodies()
		
		for body in bodies:
			if (body is Enemy):
				body.air(global_position, airStrength)
		areaShape.disabled = true
	if timer >= 0.5:
		queue_free()
	timer+=delta
