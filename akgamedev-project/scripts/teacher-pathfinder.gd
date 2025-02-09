extends CharacterBody2D

@export var SPEED: int = 100
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
var point_light: PointLight2D
@onready var field_of_view_mesh: MeshInstance2D = $FieldOfView/MeshInstance2D

func _ready() -> void:
	currentMax = patrolPoints.size() - 1
	point_light = PointLight2D.new()
	point_light.texture = preload("res://assets/Light.png")
	point_light.energy = 1.5
	point_light.shadow_enabled = true
	point_light.z_index = 2
	field_of_view.add_child(point_light)

func _physics_process(delta: float) -> void:
	var direction = Vector3()
	if point_light:
		point_light.global_position = field_of_view.global_position
	
	
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
		#field_of_view_mesh.visible = false		<- Debugging
		ray_cast_2d.target_position = to_local(player.global_position)
		ray_cast_2d.force_raycast_update()
		if ray_cast_2d.is_colliding():
			var collider = ray_cast_2d.get_collider()
			if collider && ("Player" in collider.name) && !player.behind_locker:
					nav.target_position = player.global_position
					#print("I SEE YOU!!!")
					visible_player = true
		else:
			#print("CANT SEE")
			visible_player = false
					
		if visible_player:
			calm_down = 0;
		else:
			calm_down += 5 * delta;
			
		if calm_down >= 10:
			mode = 0;
			calm_down = 10;
			
	
	direction = nav.get_next_path_position() - global_position
	direction = direction.normalized()
	
	var anget_multiplier = 1
	if mode == 1:
		anget_multiplier = 1.5
	velocity = velocity.lerp(direction * SPEED * anget_multiplier, 7 * delta)
	
	# update the rotation of the field of view
	field_of_view.look_at(nav.get_next_path_position())
	field_of_view.rotation_degrees += 90
	
	move_and_slide()
