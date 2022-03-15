extends Sprite
class_name FireBall

var fireStrength = 0

var timer = 0
var direction : Vector2 = Vector2.ONE

const SPEED = 5

func _process(delta: float) -> void:
	position += direction * SPEED
	if timer >= 5:
		queue_free()
	timer += delta

func bodyCollided(body: Node) -> void:
	if (body is PC):
		return
	if not (body is PC):
		body.fire(fireStrength)
	queue_free()
