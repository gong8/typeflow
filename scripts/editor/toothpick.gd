extends Node2D

var dragging = false
var max_value = 100.0
var value = 0.0
var id : int
var bpm : int = 60.0
var tracks : int = 1

func set_x(x):
	global_position.x = max(360, min(1560, x))
	value = max_value * (global_position.x - 360) / 1200

func set_value(new_value):
	value = new_value
	set_x((value / max_value) * 1200 + 360)

func update_properties():
	Global.root.map_manager.changes[id]["time"] = value
	Global.root.map_manager.changes[id]["bpm"] = bpm
	Global.root.map_manager.changes[id]["tracks"] = tracks
	
	print(Global.root.map_manager.changes)

func _on_handle_down():
	dragging = true
	Global.root.get_node("TimingMenu").selected_toothpick = self

func _on_handle_up():
	dragging = false

func _ready():
	position.y = 640

func _process(_delta):
	if Global.root.get_node("TimingMenu").selected_toothpick == self:
		modulate = Color8(200, 200, 200)
	else:
		modulate = Color8(255, 255, 255)
	
	if dragging:
		set_x(get_global_mouse_position().x)
		update_properties()
		if Global.root.get_node("TimingMenu").selected_toothpick != null:
			Global.root.get_node("TimingMenu").update_vals()
