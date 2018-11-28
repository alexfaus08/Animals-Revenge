extends NinePatchRect

onready var mixing_station = $"../Appliances/Mixing Station"


func _on_Slight_pressed():
	mixing_station.which_poison(mixing_station.simple_poison_percent)
	mixing_station.poison()
	hide()


func _on_Better_pressed():
	mixing_station.which_poison(mixing_station.better_poison_percent)
	mixing_station.poison()
	hide()


func _on_Killer_pressed():
	mixing_station.which_poison(mixing_station.killer_poison_percent)
	mixing_station.poison()
	hide()
