extends CharacterBody2D


<<<<<<< HEAD
const SPEED = 350.0
=======
>>>>>>> 12e67743c46d054ab8822c39299643f9c8e80b99


func _physics_process(_delta: float) -> void:
	var dX := Input.get_axis("ui_left", "ui_right")
	var dY := Input.get_axis("ui_up", "ui_down")
	velocity.x = dX * SPEED
	velocity.y = dY * SPEED


	move_and_slide()
