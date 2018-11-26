extends Control


func _ready():
	hide()

func game_over():
	show()
	get_tree().paused = true
	# print the score


func _on_New_Game_pressed():
	print("New Game")
	get_tree().reload_current_scene()
	get_tree().paused = false


func _on_Quit_pressed():
	print("Quit")
	get_tree().quit()
