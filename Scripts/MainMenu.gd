extends Node2D


func newGamePressed() -> void:
	GlobalScope.switchToGame()


func optionsPressed() -> void:
	pass # Replace with function body.


func closePressed() -> void:
	GlobalScope.quit()
