extends Enemy

var timer = 0

func _process(delta: float) -> void:
	if currentTarget != null and timer >= 1 and not game.pause:
		if global_position.distance_to(currentTarget.global_position) <= 10:
			currentTarget.takeDamage(damage)
			timer = 0
	if not game.pause:
		timer += delta
