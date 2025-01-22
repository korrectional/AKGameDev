extends CharacterBody2D

@onready var nav: NavigationAgent2D = $NavigationAgent2D
@export var mode: int = 0 # 0 = patrol, 1 = chase 

func _physics_process(delta: float) -> void:
	
	var direction = Vector3()
	
	if mode == 0:
		print(0)
	if mode == 1:
		print(1)
		
	nav.target_position = get_global_mouse_position()
	direction = nav.get_next_path_position() - global_position
	direction = direction.normalized()
	
	velocity = velocity.lerp(direction * 100, 7 * delta)
	
	move_and_slide()
