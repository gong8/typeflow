extends Node2D

var dragging = false
var max_value = 100.0
var value = 0.0

func set_x(x):
	global_position.x = max(360, min(1560, x))
	value = max_value * (x - 360) / 1200

func set_value(new_value):
	value = new_value
	set_x((value / max_value) * 1200 + 360)

func _on_handle_down():
	dragging = true

func _on_handle_up():
	dragging = false

func _ready():
	position.y = 640

func _process(_delta):
	if dragging:
		set_x(get_global_mouse_position().x)
