extends Sprite

var fireStrength = 0

func bodyCollided(body: Node) -> void:
	if not (body is PC):
		body.fire(fireStrength)
	queue_free()
