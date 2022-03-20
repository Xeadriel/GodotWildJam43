extends Node2D

onready var help = $Help

func newGamePressed() -> void:
	GlobalScope.switchToGame()


func optionsPressed() -> void:
	help.visible = true


func closePressed() -> void:
	GlobalScope.quit()


func _on_secret_pressed() -> void:
	OS.shell_open("https://www.youtube.com/watch?v=dQw4w9WgXcQ")


func _on_Close_pressed() -> void:
	help.visible = false
