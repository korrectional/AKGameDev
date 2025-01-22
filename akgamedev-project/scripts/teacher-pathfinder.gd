extends CharacterBody2D

@onready var nav: NavigationAgent2D = $NavigationAgent2D
@export var mode: int = 0 # 0 = patrol, 1 = chase 
@export var patrolPoints: Array[Node2D]
@onready var field_of_view: Node2D = $FieldOfView
@onready var field_of_view_collider: Area2D = $FieldOfView/Area2D
@onready var ray_cast_2d: RayCast2D = $RayCast2D

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
			if current > currentMax:
				current = 0
		
		# check if sees something
		var within_view = field_of_view_collider.get_overlapping_areas()
		for object in within_view: # look at all objects
			if "Player" in object.name:
				# found player
				ray_cast_2d.target_position = to_local(object.global_position)
				
				# Update the raycast to perform collision checks
				ray_cast_2d.force_raycast_update()

				if ray_cast_2d.is_colliding():
					var collider = ray_cast_2d.get_collider()
					if collider:
						if "Player" in collider.name:
							print("I SEE YOU!!!")
							mode = 1



				
		
		
		
	if mode == 1:
		print(1)
	
	direction = nav.get_next_path_position() - global_position
	direction = direction.normalized()
	
	# speed is 50
	velocity = velocity.lerp(direction * 50, 7 * delta)
	
	# update the rotation of the field of view
	field_of_view.look_at(nav.get_next_path_position())
	field_of_view.rotation_degrees += 90
	
	move_and_slide()
