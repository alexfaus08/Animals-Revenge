extends RichTextLabel

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
var obj_name

func get_object_name(object):
	if(typeof(object) == TYPE_STRING):
		obj_name = object
	elif(typeof(object) == TYPE_ARRAY):
		obj_name = str(object)
	else:
		if(object.is_poisoned()):
			obj_name = "[color=red]Poisoned[/color] %s" % object.get_name() 
		else:
			obj_name  = object.get_name()
	return obj_name