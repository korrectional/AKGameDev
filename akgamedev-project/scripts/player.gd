extends CharacterBody2D

var SPEED = 3.0
var behind_locker = false
var spaceOn = false	
var is_energy_taken = false
var oldPos: Vector2
var collisionInfo
@export var locker_instructions: TextEdit	#Textbox for the instructions (TODO: change from using visible to manipulating the inner text)
@export var mesh: MeshInstance2D
@export var camera: Camera2D
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

func collidingLocker(currently: bool, collision=null): # this one is called by the area2d in player
	collisionInfo = collision
	if (currently or behind_locker):
		locker_instructions.visible = true
		#Change test according to player state
		if (behind_locker):
			locker_instructions.text = "Press SPACE to exit locker"
		else:
			locker_instructions.text = "Press SPACE to enter locker"
	else:
		locker_instructions.visible = false
	near_locker = currently

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(_delta: float) -> void:
	#Movement input
	if(!behind_locker):
		position.x -= SPEED * int(Input.is_action_pressed("left"))
		position.x += SPEED * int(Input.is_action_pressed("right"))
		position.y -= SPEED * int(Input.is_action_pressed("up"))
		position.y += SPEED * int(Input.is_action_pressed("down"))
	
	move_and_slide() # this is a command to apply physics
	#Functionality for entering and exiting a locker
	if (Input.is_action_pressed("interact") and !spaceOn and near_locker):
		spaceOn = true
		if (!behind_locker):
			behind_locker = true
			oldPos = position
			position = collisionInfo.position
		else:
			position = oldPos
			behind_locker = false
	elif (!Input.is_action_pressed("interact")):
		spaceOn = false
		
	mesh.visible = !behind_locker
