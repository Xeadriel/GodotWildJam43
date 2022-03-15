extends Sprite

var pushStrength = 0
var fireStrength = 0
var earthStrength = 0

var timer = 0

func _ready():
	var bodies = $Area2D.get_overlapping_bodies()
	
	for body in bodies:
		if not (body is PC):
			body.earth(pushStrength, fireStrength, earthStrength)

func _process(delta: float) -> void:
	if timer >= 1.5:
		queue_free()
	timer+=delta
