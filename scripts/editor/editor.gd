extends Node2D

var keymap : OrderedSet

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_back_pressed():
	get_tree().change_scene_to_file("res://scenes/menu.tscn")


func _on_timing_pressed():
	if Global.screen == "editor":
		var inst = load("res://scenes/timing_menu.tscn").instantiate()
		inst.position = Vector2(1920/2, 1080/2)
		add_child(inst)
		Global.screen = "timing"


func _on_file_dialog_file_selected(path):
	var music = AudioStreamPlayer.new()
	var stream = load(path)
	music.set_stream(stream)
	music.volume_db = 1
	music.pitch_scale = 1
	add_child(music)
	music.add_to_group("songs")


func _on_grid_button_pressed():
	pass # Replace with function body.

var cycle = [1, 2, 3, 4, 6]
var cycle_pos = 3

func set_factor():
	$Grid.factor = cycle[cycle_pos]
	$EditorBar/GridTimeToggle.text = str("1/" + str($Grid.factor))

func _on_grid_time_toggle_pressed():
	cycle_pos = (cycle_pos + 1) % len(cycle)
	set_factor()

func _ready():
	set_factor()
