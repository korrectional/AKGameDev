extends ProgressBar

# IN DEVELOPMENT!

func _process(_delta: float) -> void:
	if get_parent().get_parent().is_energy_taken == true:
		count_energy()


func count_energy():
	pass

func _on_timer_timeout() -> void:
	pass # Replace with function body.
