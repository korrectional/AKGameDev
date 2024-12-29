extends ProgressBar

# IN DEVELOPMENT!
@onready var player = $".."

# This script is used to count the energy of the player
func _process(_delta: float) -> void:
	if (self.value <= 0):
		self.visible = false;
	else:
		self.visible = true;
	if player.is_energy_taken == true:
		self.value = count_energy()

# This function counts the energy of the player
func count_energy() -> float:
	return (player.timer.time_left / player.timer.wait_time) * 100

# This function is called when the timer is finished
func _on_timer_timeout() -> void:
	pass # Replace with function body.
