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
		

func _ready():
	# initialize all recipes here
	var Mashed_Potatoes = Recipe.new(["Potatoes", "Butter", "Milk"], 10, "Stove")
	recipes.append(Mashed_Potatoes)
	pass
	
func get_recipes():
	return recipes
