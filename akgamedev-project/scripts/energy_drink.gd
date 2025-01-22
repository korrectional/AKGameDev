extends Area2D

var active: bool = true
var timer: Timer
@onready var player: CharacterBody2D = $"../Player"

#Sets up timer
func _ready() -> void:
	timer = Timer.new()
	timer.autostart = false
	timer.one_shot = true
	timer.wait_time = 3.0	#Change for diff respawn time for drink
	add_child(timer)

#Drink respawn stuff. 
func _process(delta: float) -> void:
	if (!active):
		self.visible = false
		if (timer.time_left <= 0):
			active = true
	else:
		self.visible = true

#Consuming dru- I mean drinks
func _on_area_entered(area: Area2D) -> void:
	if (area.name == "Player" and active):
		active = false
		player.is_energy_taken = true
		player.timer.start()
		self.timer.start()
