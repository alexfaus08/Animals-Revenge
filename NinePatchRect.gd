extends NinePatchRect

onready var Player = $"../Player"
onready var Fridge = $"../Appliances/Fridge"

func _process(delta):
	if(Fridge.player_near_fridge == false):
		hide()

func _on_Milk_pressed():
	Player.add_object("Milk")
	hide()



func _on_Butter_pressed():
	Player.add_object("Butter")
	hide()
	
	


func _on_Turkey_pressed():
	Player.add_object("Turkey")
	hide()


func _on_Chicken_pressed():
	Player.add_object("Chicken")
	hide()


func _on_Cheese_pressed():
	Player.add_object("Cheese")
	hide()
