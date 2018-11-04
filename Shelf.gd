extends Area2D

# Stove.gd uses a very similiar layout. See Stove.gd for documentation.

var player_near_shelf
func _ready():
	player_near_shelf = false
	
	
func _process(delta):
	pass

func _on_Shelf_body_entered(body):
	if(body.get_name() == "Player"):
		player_near_shelf = true


func _on_Shelf_body_exited(body):
	if(body.get_name()  == "Player"):
		player_near_shelf = false 
