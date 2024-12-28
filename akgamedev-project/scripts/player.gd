extends CharacterBody2D

var speed = 3.0
var behind_locker = false
var spaceOn = false	
var is_energy_taken = false
var energyLeft: int = 0
var timeActivated: int
var oldPos: Vector2
var collisionInfo
@onready var locker_instructions: TextEdit = $"TextEdit"	#Textbox for the instructions
@onready var mesh: MeshInstance2D = $"MeshInstance2D"
@onready var camera: Camera2D = $"Camera2D"
@onready var spawnPoints: Node2D = $"../SpawnPoints"
var timer: Timer
var near_locker = false


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

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	timer = Timer.new()
	timer.autostart = false
	timer.one_shot = true
	timer.wait_time = 2.0
	add_child(timer)
	if(false): # not using this rn for development purposes
		print(get_parent().name)
		var sp = spawnPoints.get_children() 
		var pointNum = int(randf() * len(sp)) #chooses a random point to start at
		position = sp[pointNum].position

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(_delta: float) -> void:
	#Movement input
	if(!behind_locker):
		position.x -= speed * int(Input.is_action_pressed("left"))
		position.x += speed * int(Input.is_action_pressed("right"))
		position.y -= speed * int(Input.is_action_pressed("up"))
		position.y += speed * int(Input.is_action_pressed("down"))
	
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
	
	if (timer.time_left <= 0 and is_energy_taken):
		is_energy_taken = false
	
	if (is_energy_taken):
		self.speed = 6.0
	else:
		self.speed = 3.0
