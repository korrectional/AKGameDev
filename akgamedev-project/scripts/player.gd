extends CharacterBody2D

var SPEED = 3.0
var behind_locker = false
var spaceOn = false	
var is_energy_taken = false
@export var locker_instructions: TextEdit	#Textbox for the instructions (TODO: change from using visible to manipulating the inner text)
@onready var spawnPoints: Node2D = $"../SpawnPoints"
var near_locker = false

	# TAKE_INPUT function taken out because it only allowed one input at the time
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if(false): # not using this rn for development purposes
		print(get_parent().name)
		var sp = spawnPoints.get_children() 
		var pointNum = int(randf() * len(sp)) #chooses a random point to start at
		position = sp[pointNum].position

func collidingLocker(currently: bool): # this one is called by the area2d in player
	locker_instructions.visible = currently
	near_locker = currently

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(_delta: float) -> void:
	#input
	
	#Movement input
	if(visible):
		position.x -= SPEED * int(Input.is_action_pressed("left"))
		position.x += SPEED * int(Input.is_action_pressed("right"))
		position.y -= SPEED * int(Input.is_action_pressed("up"))
		position.y += SPEED * int(Input.is_action_pressed("down"))
	
	move_and_slide() # this is a command to apply physics
	
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
