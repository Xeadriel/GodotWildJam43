extends Node2D


func _process(delta: float) -> void:
	if visible:
		var mousePos = get_global_mouse_position()
		rotation = global_position.angle_to_point(mousePos)
