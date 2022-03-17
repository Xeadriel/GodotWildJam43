extends AnimatedSprite

onready var yang = get_parent()

func _process(delta: float) -> void:
	if visible:
		global_position = get_global_mouse_position()
		var mousePos = get_global_mouse_position()
		rotation = yang.global_position.angle_to_point(mousePos)
