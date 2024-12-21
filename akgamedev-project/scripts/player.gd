extends Area2D

var SPEED = 3.0
var behind_locker = false
var spaceOn = false	
var is_energy_taken = false
@export var locker_instructions: TextEdit	#Textbox for the instructions (TODO: change from using visible to manipulating the inner text)
@onready var spawnPoints: Node2D = $"../SpawnPoints"

	# TAKE_INPUT function taken out because it only allowed one input at the time

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print(get_parent().name)
	var sp = spawnPoints.get_children()
	var pointNum = int(randf() * len(sp)) #chooses a random point to start at
	position = sp[pointNum].position

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(_delta: float) -> void:
	#Make sure the vars are false before doing checks
	locker_instructions.visible = false
	var near_locker = false
	
	#input
	
	#Movement input
	if(visible):
		position.x -= SPEED * int(Input.is_action_pressed("left"))
		position.x += SPEED * int(Input.is_action_pressed("right"))
		position.y -= SPEED * int(Input.is_action_pressed("up"))
		position.y += SPEED * int(Input.is_action_pressed("down"))
	
	#Collision detection (TODO: Put it into its own function for better reusability and legibility) 
	var collisions = get_overlapping_areas();
	for collision in collisions:
		if "Lockers" in collision.get_groups():
			locker_instructions.visible = true
			near_locker = true
	
	#Functionality for entering and exiting a locker (TODO: Fix potential bugs and clean up junk code if possible)
	if (Input.is_action_pressed("interact") and !spaceOn and near_locker):
		spaceOn = true
		if (!behind_locker):
			behind_locker = true
			visible = true
		else:
			behind_locker = false
			visible = false
	elif (!Input.is_action_pressed("interact")):
		spaceOn = false
