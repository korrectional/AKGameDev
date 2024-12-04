extends CharacterBody2D


const SPEED = 300.0


func _physics_process(_delta: float) -> void:
	var dX := Input.get_axis("ui_left", "ui_right")
	var dY := Input.get_axis("ui_up", "ui_down")
	velocity.x = dX * SPEED
	velocity.y = dY * SPEED


	move_and_slide()
