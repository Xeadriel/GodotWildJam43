extends Sprite

func _ready() -> void:
	pass


func bodyCollided(body : Node) -> void:
	if not (body is PC):
		body.magmaFist()
	queue_free()
