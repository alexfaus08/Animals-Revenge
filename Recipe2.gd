extends ColorRect


func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	pass

func set_main(main):
	$"Main1".append_bbcode(main)
	if(main == "Chicken"):
		$Main1.set_tooltip("Cook Raw Chicken in Oven")
	elif(main == "Ham"):
		$Main1.set_tooltip("Cook Raw Ham in Oven")
	elif(main == "Turkey"):
		$Main1.set_tooltip("Cook Raw Turkey in Oven")
	
	print(main)
	
func clear_text():
	$"Main1".clear()