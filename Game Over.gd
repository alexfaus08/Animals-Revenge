extends Control
var score = 0


func _ready():
	hide()

func game_over():
	show()
	score = $"../Sidebar".get_score()
	$"SCORE NUM".set_text(str(score))
	get_tree().paused = true
	# print the score


func _on_New_Game_pressed():
	print("New Game")
	get_tree().reload_current_scene()
	get_tree().paused = false


func _on_Quit_pressed():
	print("Quit")
	get_tree().quit()
