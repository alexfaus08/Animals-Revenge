extends KinematicBody2D

export var motion_speed = 100

var RayNode
var motion = Vector2()

func _ready():
	set_physics_process(true)
	pass
	
func _physics_process(delta):
	
	if Input.is_action_pressed("ui_up"):
		motion.y = -motion_speed 
		
	if Input.is_action_pressed("ui_down"):
		motion.y = motion_speed

	
	if Input.is_action_pressed("ui_left"):
		motion.x = -motion_speed
	
	
	if Input.is_action_pressed("ui_right"):
		motion.x = motion_speed
	
	
		# RayNode.set_rotd(90)
	move_and_slide(motion)
	motion.x = 0
	motion.y =0