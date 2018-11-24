extends StaticBody2D

var contents_on_table = []
var waiting_orders = []
var none = false
var order_ready = false

func get_contents_on_table():
	if(contents_on_table.size() == 0):
		none = true
		return none
	else:
		return contents_on_table
		
func get_waiting_dishes():
	if(waiting_orders.size() == 0):
		none = true
		return none
	else:
		return waiting_orders
		
