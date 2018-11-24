extends NinePatchRect

onready var mixing_station = $"../Appliances/Mixing Station"


func _on_Slight_pressed():
	mixing_station.which_poison(.25)
	mixing_station.poison()
	hide()


func _on_Better_pressed():
	mixing_station.which_poison(.50)
	mixing_station.poison()
	hide()


func _on_Killer_pressed():
	mixing_station.which_poison(1)
	mixing_station.poison()
	hide()
