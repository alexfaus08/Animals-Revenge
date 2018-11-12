extends NinePatchRect

onready var Player = $"../Player"
onready var Shelf = $"../Appliances/Shelf"

func _process(delta):
	if(Shelf.player_near_shelf == false):
		hide()


func _on_Potato_pressed():
	Player.add_object("Potatoes")
	hide()

