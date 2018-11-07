extends NinePatchRect

onready var Player = $"../Player"
onready var Fridge = $"../Appliances/Fridge"

func _process(delta):
	if(Fridge.player_near_fridge == false):
		hide()


func _on_Potato_pressed():
	Player.add_object("Potatoes")
	hide()