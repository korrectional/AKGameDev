extends Area2D

const SPEED = 230.0
var behind_locker = false
var spaceOn = false		#To make sure you cant enter and exit a locker by holding down space
@export var locker_instructions: TextEdit	#Textbox for the instructions (TODO: change from using visible to manipulating the inner text)

func takeInput(delta: float) -> String:			# Returns strings based on key pressed
	if (Input.is_action_pressed("ui_right")):
		return "right"
	elif (Input.is_action_pressed("ui_left")):
		return "left"
	
	if (Input.is_action_pressed("ui_up")):
		return "up"
	elif (Input.is_action_pressed("ui_down")):
		return "down"
		
	if (Input.is_key_pressed(KEY_SPACE)):
		return "space"
	else:
		return "space-up"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	#Make sure the vars are false before doing checks
	locker_instructions.visible = false
	var near_locker = false
	
	#input
	var input = takeInput(delta)
	
	#Movement input
	if (input == "right" && visible):
		position.x += SPEED * delta
	elif (input == "left" && visible):
		position.x -= SPEED * delta
	if (input == "up" && visible):
		position.y -= SPEED * delta
	elif (input == "down" && visible):
		position.y += SPEED * delta
	
	#Collision detection (TODO: Put it into its own function for better reusability and legibility) 
	var collisions = get_overlapping_areas();
	for collision in collisions:
		if "Lockers" in collision.get_groups():
			locker_instructions.visible = true
			near_locker = true
	
	#Functionality for entering and exiting a locker (TODO: Fix potential bugs and clean up junk code if possible)
	if (input == "space" and !spaceOn and near_locker):
		spaceOn = true
		if (!behind_locker):
			behind_locker = true
			visible = true
		else:
			behind_locker = false
			visible = false
	elif (input == "space-up"):
		spaceOn = false
