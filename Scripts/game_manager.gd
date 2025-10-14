extends Node

var score: Label

func gameOver() -> void:
	var gameOverMenu = get_tree().get_first_node_in_group("game_over")
	gameOverMenu.visible = true
	Engine.time_scale = 0.
	
#func pause() -> void:
	#TODO
	
func restart() -> void:
	get_tree().reload_current_scene()
	Engine.time_scale = 1.
	
func quit() -> void:
	get_tree().quit()

func updateScore(newScore: int) -> void:
	score = get_tree().get_first_node_in_group("scoreLabel")
	score.text = "Enemies killed: " + str(newScore)
