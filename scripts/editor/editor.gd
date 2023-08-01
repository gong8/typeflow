extends Node2D

var screen : String = "editor"
var keymap : OrderedSet

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_timing_button_up():
	if screen == "editor":
		var inst = load("res://scenes/timing_menu.tscn").instantiate()
		inst.position = Vector2(1920/2, 1080/2)
		add_child(inst)
		screen = "timing"
