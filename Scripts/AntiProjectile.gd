extends Projectile
class_name AntiProjectile



func bodyCollided(body: Node) -> void:
	if not (body is EnemyProjectile):
		return
	if (body is EnemyProjectile):
		body.antiProjectile()
	queue_free()
