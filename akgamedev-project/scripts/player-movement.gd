extends CharacterBody2D

const SPEED = 250.0

func _physics_process(_delta: float) -> void:
	$TextEdit.visible = false #hides text that tells the player how to hide in a locker
	
	for i in get_slide_collision_count():
		var collision = get_slide_collision(i).get_collider().name #detects what object the player is colliding with
		if collision == "Locker":
			$TextEdit.visible = true #while colliding with the locker, show text that tells the player how to hide
			if Input.is_action_just_pressed("interact"):
				visible = false #delete this line later; code should switch player into a hiding state
	
	var dX := Input.get_axis("ui_left", "ui_right")
	var dY := Input.get_axis("ui_up", "ui_down")
	velocity.x = dX * SPEED
	velocity.y = dY * SPEED


	move_and_slide()
