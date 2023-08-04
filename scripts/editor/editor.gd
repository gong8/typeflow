extends Node2D

var keymap : OrderedSet
var grid_showing: bool = true
var map_manager = MapManager.new()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_released("Click"):
		print(get_global_mouse_position().y)


func _on_back_pressed():
	Global.screen = "main_menu"
	get_tree().change_scene_to_file("res://scenes/menu.tscn")


func _on_timing_pressed():
	if Global.screen == "editor":
		$TimingMenu.visible = true
		Global.screen = "timing"


func _on_file_dialog_file_selected(path):
	var music = AudioStreamPlayer.new()
	var stream = load(path)
	music.set_stream(stream)
	music.volume_db = 1
	music.pitch_scale = 1
	add_child(music)
	music.add_to_group("songs")
	
	var timing_music = AudioStreamPlayer.new()
	var timing_stream = load(path)
	timing_music.set_stream(timing_stream)
	timing_music.volume_db = 1
	timing_music.pitch_scale = 1
	add_child(timing_music)
	timing_music.add_to_group("timing_songs")


func _on_grid_button_pressed():
	if grid_showing:
		grid_showing = false
	else:
		grid_showing = true
	

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
	Global.root = self
