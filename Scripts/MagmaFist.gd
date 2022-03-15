extends Sprite
class_name MagmaFist

onready var areaShape = $Area2D/CollisionShape2D
onready var effectArea = $EffectArea
onready var effectAreaShape = $EffectArea/EffectShape

var direction : Vector2 = Vector2.ONE

const SPEED = 5

var activated = false
var timer = 0
var expirationTimer = 0

func bodyCollided(body : Node) -> void:
	if (body is PC):
		return
	if not (body is PC):
		areaShape.disabled = true
		activated = true
		effectAreaShape.disabled = false
		effectArea.global_position = body.global_position
		effectArea.rotation = effectArea.global_position.angle_to_point(effectArea.global_position + direction)


func _process(delta: float) -> void:
	position += direction * SPEED
	if expirationTimer >= 5:
		queue_free()
	expirationTimer+= delta
	if activated:
		if timer >= 0.001:
			var bodies = effectArea.get_overlapping_bodies()
			for body in bodies:
				if not (body is PC):
					body.magmaFist(direction)
			effectAreaShape.disabled = true
		if timer >= 1.5:
			queue_free()
		timer+=delta
