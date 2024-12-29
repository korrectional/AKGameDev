extends ProgressBar

# IN DEVELOPMENT!

# This script is used to count the energy of the player
func _process(_delta: float) -> void:
	if get_parent().get_parent().is_energy_taken == true:
		count_energy()

# This function counts the energy of the player
func count_energy():
	pass

# This function is called when the timer is finished
func _on_timer_timeout() -> void:
	pass # Replace with function body.
