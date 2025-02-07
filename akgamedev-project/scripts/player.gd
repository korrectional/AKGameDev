extends CharacterBody2D

@export var SPEED = 170 # base speed
@export var friction = 0.4
@export var acceleration = 0.2
var speed = SPEED # Speed with modifiers
var speedMultiplier = 1.0;
var behind_locker = false
var spaceOn = false # To prevent someone holding space and jumping in and out of a locker
var is_energy_taken = false # If consumed drink
var phone_collected = false
var oldPos: Vector2 # For the locker entry and exit
var collisionInfo # Collision info for a locker
@onready var locker_instructions: TextEdit = $"TextEdit"	# Textbox for the instructions
@onready var mesh: Sprite2D = $"PlayerIdle2"	# player "mesh" (changed to sprite but not var name)
@onready var camera: Camera2D = $"Camera2D"
@onready var spawnPoints: Node2D = $"../SpawnPoints"
@onready var collider: CollisionShape2D = $CollisionShape2D
var timer: Timer
var near_locker = false

# Called by Player's area2D on collision with a locker
func collidingLocker(currently: bool, collision=null):
	collisionInfo = collision
	if (currently or behind_locker):
		locker_instructions.visible = true
		# Change test according to player state
		if (behind_locker):
			locker_instructions.text = "Press SPACE to exit locker"
		else:
			locker_instructions.text = "Press SPACE to enter locker"
	else:
		locker_instructions.visible = false
	near_locker = currently

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#Setting up timer for energy drink
	timer = Timer.new()
	timer.autostart = false
	timer.one_shot = true
	timer.wait_time = 2.0
	add_child(timer)
	
	
	# Random spawn points, keep false for development
	if(false):
		var sp = spawnPoints.get_children() 
		var pointNum = int(randf() * len(sp)) # chooses a random point to start at
		position = sp[pointNum].position

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(_delta: float):
	# Applies speed multipliers;
	speed = SPEED * speedMultiplier
	
	# Movement input
	if(!behind_locker):
		var direction = Input.get_vector("left", "right", "up", "down")
		if direction.length() > 0:
			velocity = velocity.lerp(direction.normalized() * speed, acceleration)
		else:
			velocity = velocity.lerp(Vector2.ZERO, friction)
	else:
		velocity = Vector2.ZERO
		
	move_and_slide() # this is a command to apply physics
	
	# Functionality for entering and exiting a locker
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
	
	# Sets visibilty of player according to state
	if !(mesh.visible and !behind_locker):
		mesh.visible = !behind_locker
	collider.disabled = behind_locker # disable the collider too
	
	# When to deactivate speed boost
	if (timer.time_left <= 0 and is_energy_taken):
		is_energy_taken = false
	
	# Speed boost once the drink taken
	if (is_energy_taken):
		self.speedMultiplier = 1.75
	else:
		self.speedMultiplier = 1
		
	if (timer.time_left <= 0 and phone_collected):
		phone_collected = false
