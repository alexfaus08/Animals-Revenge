extends NinePatchRect

onready var Player = $"../Player"
onready var Shelf = $"../Appliances/Shelf"

func _process(delta):
	if(Shelf.player_near_shelf == false):
		hide()


func _on_Potatoes_pressed():
	Player.add_object("Potatoes")
	hide()


func _on_Celery_pressed():
	Player.add_object("Celery")
	hide()


func _on_Corn_pressed():
	Player.add_object("Corn")
	hide()


func _on_Cranberries_pressed():
	Player.add_object("Cranberries")
	hide()


func _on_Bread_pressed():
	Player.add_object("Bread")
	hide()


func _on_Apples_pressed():
	Player.add_object("Apples")
	hide()
