extends ProgressBar

@onready var player = $".."

#Sets the value of the progress bar
func _process(_delta: float) -> void:
	if (self.value <= 0):
		self.visible = false;
	else:
		self.visible = true;
	if player.is_energy_taken == true:
		self.value = count_energy()

# Counts the energy the player has left
func count_energy() -> float:
	return (player.timer.time_left / player.timer.wait_time) * 100
