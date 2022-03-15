extends Node2D

var fireStrength = 0
var pushStrength = 0

var timer = 0

func _ready():
	var bodies = $Area2D.get_overlapping_bodies()
	
	for body in bodies:
		if not (body is PC):
			body.force(pushStrength, fireStrength)

func _process(delta: float) -> void:
	if timer >= 1.5:
		queue_free()
	timer+=delta
