extends PopupMenu

onready var Player = $"../Player"

func _on_Potato_pressed():
	Player.add_object("Potato")
	hide()