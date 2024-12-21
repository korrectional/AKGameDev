extends Area2D




func _on_area_entered(area: Area2D) -> void:
	area.get_parent().SPEED = 7
	self.queue_free()
	area.get_parent().is_energy_taken = true
	print("dd")
