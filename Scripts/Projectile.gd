extends AnimatedSprite
class_name Projectile

onready var game = get_parent()

var timer = 0
var direction : Vector2 = Vector2.ONE

const SPEED = 5

func _process(delta: float) -> void:
	if game.pause:
		return
	position += direction * SPEED
	if timer >= 5:
		queue_free()
	timer += delta
