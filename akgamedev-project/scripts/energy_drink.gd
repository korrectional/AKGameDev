extends Area2D

var active: bool = true
var timer: Timer

func _ready() -> void:
	timer = Timer.new()
	timer.autostart = false
	timer.one_shot = true
	timer.wait_time = 3.0
	add_child(timer)

func _process(delta: float) -> void:
	if (!active):
		self.visible = false
		if (timer.time_left <= 0):
			active = true
	else:
		self.visible = true

func _on_area_entered(area: Area2D) -> void:
	if (area.name == "Player" and active):
		active = false
		area.get_parent().is_energy_taken = true
		area.get_parent().timer.start()
		self.timer.start()
		print("Drugs activated")
