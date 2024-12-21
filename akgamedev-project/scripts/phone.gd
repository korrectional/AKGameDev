extends Node2D

var phone_collected = false
var player_in_area = false

# Called when the node enters the scene tree for the first time.

# Called every frame. 'delta' is the elapsed time since the previous frame.


func _process(_delta: float) -> void:
	if phone_collected == false:
		$sprite2d.play(false)
	if phone_collected == true:
		$sprite2d.play(true)
		if player_in_area:
			if Input.is_action_just_pressed("e"):
				phone_collected = false



func _on_area_2d_body_entered(body: Node2D) -> void:
	pass # Replace with function body.
