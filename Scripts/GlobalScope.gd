extends Node


func switchToGame():
	var scene = get_tree().get_current_scene()
	scene.queue_free()
	var s = ResourceLoader.load("res://Scenes/Game.tscn")
	scene = s.instance()

	get_tree().get_root().add_child(scene)
	get_tree().set_current_scene(scene)


func quit():
	get_tree().quit()
