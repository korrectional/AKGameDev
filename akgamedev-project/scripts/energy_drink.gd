extends Area2D



# When the player touches the energy drink, the speed of the player is increased
func _on_area_entered(area: Area2D) -> void:
	area.get_parent().speed *= 2
	self.queue_free()
	area.get_parent().is_energy_taken = true
	print("Drugs activated")
