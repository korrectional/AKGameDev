extends Area2D
@onready var player: CharacterBody2D = $".."



func _process(_delta: float) -> void:
#Collision detection
	var collisions = get_overlapping_areas();
	if(collisions.size()==0):
		player.collidingLocker(false)
	for collision in collisions:
		if "Lockers" in collision.get_groups():
			player.collidingLocker(true, collision)
			
