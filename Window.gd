extends Area2D

# Stove.gd uses a very similiar layout. See Stove.gd for documentation.

var player_near_window
func _ready():
	player_near_window = false
	
func _recipies_Main_Course():
	var dishes = []
	var turkey = "turkey"
	var chicken = "chicken"
	var ham = "ham"
	dishes.append(turkey)
	dishes.append(chicken)
	dishes.append(ham)
	var dish_number = randi()%3
	return dishes[dish_number]

func _recipies_Sides():
	var side_dishes = []
	var mashed_potatoes = "mashed potatoes"
	var cranberry_sauce = "cranberry sauce"
	var stuffing = "stuffing"
	var creamed_corn = "creamed corn"
	var green_beans = "green beans"
	side_dishes.append(mashed_potatoes)
	side_dishes.append(cranberry_sauce)
	side_dishes.append(stuffing)
	side_dishes.append(creamed_corn)
	side_dishes.append(green_beans)
	var side_dish_number = randi()%5
	return side_dishes[side_dish_number]
	

func _process(delta):
	if(player_near_window):
		if(Input.is_action_just_pressed("ui_select")):
			print(_recipies_Main_Course())
			print(_recipies_Sides() + "\n")

func _on_Window_body_entered(body):
	if (body.get_name() == "Player"):
		player_near_window = true


func _on_Window_body_exited(body):
	if (body.get_name() == "Player"):
		player_near_window = false

