extends Area2D

const SPEED = 230.0
var behind_locker = false
var spaceOn = false
@export var locker_instructions: TextEdit

func takeInput(delta: float) -> String:
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
	locker_instructions.visible = false
	var near_locker = false
	
	var input = takeInput(delta)
	
	if (input == "right" && visible):
		position.x += SPEED * delta;
	elif (input == "left" && visible):
		position.x -= SPEED * delta;
	
	if (input == "up" && visible):
		position.y -= SPEED * delta
	elif (input == "down" && visible):
		position.y += SPEED * delta

	var collisions = get_overlapping_areas();
	for collision in collisions:
		if "Lockers" in collision.get_groups():
			locker_instructions.visible = true
			near_locker = true
			
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
