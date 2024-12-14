#extends Node2D
def come_out_of_school():
	# Player comes out of school in top-down view and walks to entrence to tennis courts or all the other fields 

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	randomize()
# Random number for fields
	var ramdom = RandomNumberGenerator.new()
	random.randomize()
	range = print(randi_range(1,4))


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	


# Setting up variables for the randomness
var tennis_courts = 1
# Top left baseball field is field 1 and the top right is feild two
var baseball_field_one = 2
var baseball_field_two = 3
var football_field = 4

if range = tennis_courts():
	print("This is the code for the tennis court ending")
else:
	if range = baseball_field_one():
		print("This is the code for the top left baseball field ending")
		else:
			if range = baseball_field_two():
				print("This is the code for the top right baseball field ending")
				else:
					if range = football_field():
						print("This is the code for the football field ending")

# Remember it will be completly random it should almost never be the same

# The basic idea is the godot figure moves to the tennis courts or the other feilds (random)
# and then escapes if it is right if it isn't you go back to last checkpoint
