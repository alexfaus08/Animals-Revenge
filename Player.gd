extends KinematicBody2D

# export allows us to change spped in the 2D editor Inspector
export var motion_speed = 100
# an array for what the character is holding
var holding = []
# a 2 dimensional vector for motion
var motion = Vector2()

onready var screen_print = $"../Bottom Box/TextPrint"
var printstring

# this function happens as the game starts
func _ready():
	# use physics for this node
	set_physics_process(true)
	# starting sprite is Idle Right
	$AnimatedSprite.play("Idle Right")
	pass

# function that is all the physics of the character
# it runs 60 times per section
func _physics_process(delta):
	# if the up arrow is being held down (see Project Settings: Input Map)
	if Input.is_action_pressed("ui_up"):
		# negative values for the y part of the vectors make the object move up
		motion.y = -motion_speed 
		if(holding.size() > 0):
			$AnimatedSprite.play("Holding Up")
		else:
			$AnimatedSprite.play("Walk Up")
		
	elif Input.is_action_pressed("ui_down"):
		# positive y values for Vector2 make the object move down
		motion.y = motion_speed
		if(holding.size() > 0):
			$AnimatedSprite.play("Holding Down")
		else:
			$AnimatedSprite.play("Walk Down")
	
	else:
		# if neither up or down arrows are being pressed, the object is not moving in
		# the y directons
		motion.y = 0
		# if the up arrow was just released make the idle animation the Idle Up
		if(Input.is_action_just_released("ui_up")):
			if(holding.size() > 0):
				$AnimatedSprite.play("Idle Up Plate")
			else:
				$AnimatedSprite.play("Idle Up")
		# if the down arrow was just released make the idle animation the Idle Down
		elif(Input.is_action_just_released("ui_down")):
			if(holding.size() > 0):
				$AnimatedSprite.play("Idle Down Plate")
			else:
				$AnimatedSprite.play("Idle Down")
	
	# if the left arrow key is being pressed down
	if Input.is_action_pressed("ui_left"):
		# negative x values for Vector2 indicate left motion
		motion.x = -motion_speed
		# the default animated sprite for the walk right is facing right
		# using .flip_h, it flips the animation to now face left
		$AnimatedSprite.flip_h = true
		if(holding.size() > 0):
			$AnimatedSprite.play("Holding Right")
		else:
			$AnimatedSprite.play("Walk Right")
	
	elif Input.is_action_pressed("ui_right"):
		motion.x = motion_speed
		$AnimatedSprite.flip_h = false
		if(holding.size() > 0):
			$AnimatedSprite.play("Holding Right")
		else:
			$AnimatedSprite.play("Walk Right")
	
	else:
		motion.x = 0
		# only need one if statement for left or right because if the key was 
		# just released, the flipping of the animation already occured.
		if(Input.is_action_just_released("ui_right") or 
		Input.is_action_just_released("ui_left")):
			if(holding.size() > 0):
				$AnimatedSprite.play("Idle Right Plate")
			else:
				$AnimatedSprite.play("Idle Right")
	
	# this tells the object where to move
	# motion is our Vector2 
	move_and_slide(motion)
	
func add_object(object):
	if (holding.size() == 0):
		holding.append(object)
		printstring = "You are holding %s \n" % holding[0]
		screen_print.append_bbcode(printstring)
		
	else:
		printstring = "You can only hold one object \n"
		screen_print.append_bbcode(printstring)
		
	

	
