#TitleScreen.gd
extends Control

func _ready():
	$"AcceptDialog".popup()
	$"Title".play()
	$"evil".play("default")
func _on_StartGameButton_pressed():
	get_tree().change_scene("res://World.tscn")
	print("In World")


func _on_QuitGameButton_pressed():
	get_tree().quit()
