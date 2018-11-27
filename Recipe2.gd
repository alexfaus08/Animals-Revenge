extends ColorRect
var main_dish
var side_dish
onready var t = $"Timer"
var active = false

func _ready():
	$"Main1".clear()
	$"Side1".clear()
	
#func _process(delta):
#	pass
#	if(active):
#		pass
#		# update progess bar
#		# check to see if time left is 0
#			# if so, deactivate

func set_main(main):
	active = true
	main_dish = main
	$"Main1".clear()
	$"Main1".append_bbcode("[center]%s[/center]" % main.get_name())
	var tooltip
	tooltip = "Ingredients: %s \n Appliance: %s" % [main.get_ingredients(), main.get_appliance()]
	$"Main1".set_tooltip(tooltip)

func set_side(side):
	side_dish = side
	$"Side1".clear()
	$"Side1".append_bbcode("[center]%s[/center]" % side.get_name())
	var tooltip
	tooltip = "Ingredients: %s \n Appliance: %s" % [side.get_ingredients(), side.get_appliance()]
	$"Side1".set_tooltip(tooltip)
	
func get_main():
	return main_dish

func get_side():
	return side_dish
	
func update_progress():
	pass

func reset_progress():
	pass