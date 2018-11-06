extends StaticBody2D

# Stove.gd uses a very similiar layout. See Stove.gd for documentation.
onready var popup = $"../../ShelfMenu"
var player_near_shelf

func _ready():
	player_near_shelf = false
	
	
func _process(delta):
	if(player_near_shelf):
		if(Input.is_action_just_pressed("ui_select")):
			popup.show()

func _on_Area2D_body_entered(body):
	if(body.get_name() == "Player"):
		player_near_shelf = true


func _on_Area2D_body_exited(body):
	if(body.get_name()  == "Player"):
		player_near_shelf = false 

