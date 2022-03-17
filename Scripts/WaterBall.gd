extends Projectile
class_name WaterBall

var waterStrength = 0

func bodyCollided(body: Node) -> void:
	if (body is PC):
		body.water(waterStrength)
		queue_free()
