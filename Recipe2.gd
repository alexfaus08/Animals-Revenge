extends ColorRect


func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	pass

func set_main(main):
	$"Main1".clear()
	$"Main1".append_bbcode("[center] %s [/center]" % main.get_name())
	var tooltip
	tooltip = "Ingredients: %s \n Appliance: %s" % [main.get_ingredients(), main.get_appliance()]
	$"Main1".set_tooltip(tooltip)

func set_side(side):
	$"Side1".clear()
	$"Side1".append_bbcode("[center] %s [/center]" % side.get_name())
	var tooltip
	tooltip = "Ingredients: %s \n Appliance: %s" % [side.get_ingredients(), side.get_appliance()]
	$"Side1".set_tooltip(tooltip)
		
	
	
	
func clear_text():
	$"Main1".clear()