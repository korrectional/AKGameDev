extends Area2D




func _on_area_entered(area: Area2D) -> void:
	area.SPEED = 1000
	self.queue_free()
	area.is_energy_taken = true
	print("dd")
