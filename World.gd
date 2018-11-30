extends Node2D
onready var world = $"."
onready var textprint = world.find_node("TextPrint")
var recipes = []
var order_expire_time = 25
var game_length = 180
var start

class Recipe:
	var r_name
	var ingredients = []
	var cook_time = 0.0
	var appliance
	var poison_percent
	
	func _init(p_name, p_ingredients, p_cook_time, p_appliance):
		r_name = p_name
		for x in p_ingredients:
			ingredients.append(x)
		ingredients.sort()
		cook_time = p_cook_time
		appliance = p_appliance
		poison_percent = 0.0
		
	func poison(percent):
		poison_percent = percent
	
	func is_poisoned():
		if(poison_percent > 0):
			return true
		else:
			return false
	
	func get_poison():
		return poison_percent
	
	func get_ingredients():
		return ingredients
		
	func get_cook_time():
		return cook_time
	
	func get_appliance():
		return appliance
	
	func get_name():
		return r_name
	
	
func _ready():
	var center = Vector2(123,63)
	$"PopupMenu".set_position(center)
	$"PopupMenu".popup()
	get_tree().paused = true
	start = false
	$"Background".play()

func initrecipes():
	# initialize all recipes here
	var Turkey = Recipe.new("Turkey", ["Raw Turkey"], 8, "Oven")
	recipes.append(Turkey)
	var Chicken = Recipe.new("Chicken", ["Raw Chicken"], 5, "Oven")
	recipes.append(Chicken)
	var Ham = Recipe.new("Ham", ["Raw Ham"], 5, "Oven")
	recipes.append(Ham)
	var Mashed_Potatoes = Recipe.new("Mashed Potatoes", ["Potatoes", "Butter", "Milk"], 5, "Stove")
	recipes.append(Mashed_Potatoes)
	var Green_Beans = Recipe.new("Green Beans", ["Green Beans", "Butter"], 5, "Stove")
	recipes.append(Green_Beans) 
	var Cranberry_Sauce = Recipe.new("Cranberry Sauce", ["Cranberries"], 8, "Stove")
	recipes.append(Cranberry_Sauce)
	var Creamed_Corn = Recipe.new("Creamed Corn", ["Corn", "Milk", "Cheese"], 3, "Oven")
	recipes.append(Creamed_Corn)
	var Stuffing= Recipe.new("Stuffing", ["Bread", "Celery", "Broth", "Butter", "Apples", "Onions"], 5, "Oven")
	recipes.append(Stuffing)
	

	
	
func get_recipes():
	if(recipes.size() == 0):
		initrecipes()
		return recipes
	else:
		return recipes

func recipe_lookup(arr):
	arr.sort()
	for r in recipes:
		if (r.get_ingredients() == arr):
			return Recipe.new(r.get_name(), r.get_ingredients(), r.get_cook_time(), r.get_appliance())



func _on_PopupMenu_index_pressed(index):
	if(index == 0):
		game_length = 180
		order_expire_time = 60
	elif(index == 1):
		game_length = 180
		order_expire_time = 45
	elif(index == 2):
		game_length = 180
		order_expire_time = 35
	else:
		get_tree().quit()
	get_tree().paused = false
	$"Recipe2/rt1".set_wait_time(order_expire_time)
	$"Recipe4/rt3".set_wait_time(order_expire_time)
	$"Recipe3/rt2".set_wait_time(order_expire_time)
	$"Sidebar/Game Timer".set_wait_time(game_length)
	$"Sidebar/Game Timer".start()
	
