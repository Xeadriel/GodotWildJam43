extends Projectile
class_name FireBall

var fireStrength = 0

func bodyCollided(body: Node) -> void:
	if (body is Enemy):
		body.fire(fireStrength)
		queue_free()
