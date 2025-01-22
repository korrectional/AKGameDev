extends CharacterBody2D

@onready var nav: NavigationAgent2D = $NavigationAgent2D
@export var mode: int = 0 # 0 = patrol, 1 = chase 
@export var patrolPoints: Array[Node2D]

var current = 0
var currentMax

func _ready() -> void:
	currentMax = patrolPoints.size() - 1

func _physics_process(delta: float) -> void:
	
	var direction = Vector3()
	
	if mode == 0:
		nav.target_position = patrolPoints[current].global_position
		if global_position.distance_to(patrolPoints[current].global_position) <= 10:
			current+=1
			print(current, ">", currentMax)
			if current > currentMax:
				print("above", patrolPoints.size())
				current = 0
		

		
		
		
	if mode == 1:
		print(1)
		
	direction = nav.get_next_path_position() - global_position
	direction = direction.normalized()
	
	# speed is 50
	velocity = velocity.lerp(direction * 50, 7 * delta)
	
	move_and_slide()
