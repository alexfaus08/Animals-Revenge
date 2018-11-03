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
		$AnimatedSprite.play("Walk Up")
		
	elif Input.is_action_pressed("ui_down"):
		motion.y = motion_speed
		$AnimatedSprite.play("Walk Up")
	
	else:
		motion.y = 0
		if(Input.is_action_just_released("ui_up")):
			$AnimatedSprite.play("Idle Up")
		elif(Input.is_action_just_released("ui_down")):
			$AnimatedSprite.play("Idle Down")
	
	if Input.is_action_pressed("ui_left"):
		motion.x = -motion_speed
		$AnimatedSprite.flip_h = true
		$AnimatedSprite.play("Walk Right")
	
	elif Input.is_action_pressed("ui_right"):
		motion.x = motion_speed
		$AnimatedSprite.flip_h = false
		$AnimatedSprite.play("Walk Right")
	
	else:
		motion.x = 0
		$AnimatedSprite.play("Idle Right")
	
	move_and_slide(motion)