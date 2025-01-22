extends Area2D

var active: bool = true
var timer: Timer

func _ready() -> void:
	pass

func _process(delta: float) -> void:
	if (!active):
		self.visible = false
	else:
		self.visible = true

func _on_area_entered(area: Area2D) -> void:
	if (area.name == "Player" and active):
		active = false
		area.get_parent().phone_collected = true
