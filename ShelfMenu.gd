extends NinePatchRect

onready var Player = $"../Player"
onready var Shelf = $"../Appliances/Shelf"

func _process(delta):
	if(Shelf.player_near_shelf == false):
		hide()


func _on_Potato_pressed():
	Player.add_object("Potatoes")
	hide()



func _on_Potatos_pressed():
	pass # replace with function body


func _on_Celery_pressed():
	pass # replace with function body


func _on_Corn_pressed():
	pass # replace with function body


func _on_Cranberries_pressed():
	pass # replace with function body


func _on_Bread_pressed():
	pass # replace with function body


func _on_Apples_pressed():
	pass # replace with function body


func _on_Onions_pressed():
	pass # replace with function body
