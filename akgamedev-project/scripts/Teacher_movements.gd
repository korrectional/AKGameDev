extends Area2D

@export var speed: float = 0.001
var distance: float = 0.0





func _process(delta: float) -> void:
	$path/position_of_object.progress_ratio = delta * speed
	self.position = $path/position_of_object.global_position
