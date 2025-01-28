extends CharacterBody2D

@export var SPEED: int = 50
@onready var nav: NavigationAgent2D = $NavigationAgent2D
@export var mode: int = 0 # 0 = patrol, 1 = chase 
@export var patrolPoints: Array[Node2D]
@onready var field_of_view: Node2D = $FieldOfView
@onready var field_of_view_collider: Area2D = $FieldOfView/Area2D
@onready var ray_cast_2d: RayCast2D = $RayCast2D
@onready var player: CharacterBody2D = $"../Player"
var visible_player = false
var calm_down = 0
var current = 0
var currentMax
@onready var field_of_view_mesh: MeshInstance2D = $FieldOfView/MeshInstance2D

func _ready() -> void:
	currentMax = patrolPoints.size() - 1

func _physics_process(delta: float) -> void:
	var direction = Vector3()
	
	# There are two "modes" for the teacher, 0: patroling two or more randomg
	# checkpoints; 1: chasing the player
	# when chasing and they cant see the player for 10 seconds teacher 
	# gives up. Also, if they see you enter a locker you get trapped
	# and lose
	
	
	# TEACHER IS PATROLING
	if mode == 0:
		field_of_view_mesh.visible = true
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






	# TEACHER IS CHASING
	if mode == 1:
		field_of_view_mesh.visible = false
		ray_cast_2d.target_position = to_local(player.global_position)
		ray_cast_2d.force_raycast_update()
		if ray_cast_2d.is_colliding():
			var collider = ray_cast_2d.get_collider()
			if collider:
				if "Player" in collider.name:
					nav.target_position = player.global_position
					#print("I SEE YOU!!!")
					visible_player = true
				else:
					#print("CANT SEE")
					visible_player = false
		else:
			#print("VISIBLE LOCKER")
			if visible_player:
				print("SAW YOU ENTER") # player loses here
				
		
		if !visible_player:
			calm_down+=delta
		if calm_down >= 10:
			mode = 0	
			
	
	direction = nav.get_next_path_position() - global_position
	direction = direction.normalized()
	
	var anget_multiplier = 1
	if mode == 1:
		anget_multiplier = 2
	velocity = velocity.lerp(direction * SPEED * anget_multiplier, 7 * delta)
	
	# update the rotation of the field of view
	field_of_view.look_at(nav.get_next_path_position())
	field_of_view.rotation_degrees += 90
	
	move_and_slide()
