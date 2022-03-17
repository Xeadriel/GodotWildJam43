extends Projectile
class_name PsiBall

var psiStrength = 0

func bodyCollided(body: Node) -> void:
	if (body is Enemy):
		body.psi(psiStrength)
		queue_free()
