extends Node2D

var recipes = []

class Recipe:
	var ingredients = []
	var cook_time = 0.0
	var appliance
	
	func _init(p_ingredients, p_cook_time, p_appliance):
		for x in p_ingredients:
			ingredients.append(x)
		cook_time = p_cook_time
		appliance = p_appliance
		
	func get_ingredients():
		return ingredients
		
	func get_cook_time():
		return cook_time
	
	func get_appliance():
		return appliance
		

func _ready():
	# initialize all recipes here
	var Turkey = Recipe.new(["Turkey"], 20, "Oven")
	recipes.append(Turkey)
	var Chicken = Recipe.new(["Chicken"], 20, "Oven")
	recipes.append(Chicken)
	var Ham = Recipe.new(["Ham"], 20, "Oven")
	recipes.append(Ham)
	var Mashed_Potatoes = Recipe.new(["Potatoes", "Butter", "Milk"], 10, "Stove")
	recipes.append(Mashed_Potatoes)
	var Green_Beans = Recipe.new(["Green Beans", "Butter"], 10, "Stove")
	recipes.append(Green_Beans) 
	var Cranberry_Sauce = Recipe.new(["Cranberries"], 8, "Stove")
	recipes.append(Cranberry_Sauce)
	var Creamed_Corn = Recipe.new(["Corn", "Milk", "Cheese"], 10, "Oven")
	recipes.append(Creamed_Corn)
	var Stuffing= Recipe.new(["Bread", "Celery", "Broth", "Butter", "Apples", "Onions"], 5, "Oven")
	recipes.append(Stuffing)
	
	
	
func get_recipes():
	return recipes


