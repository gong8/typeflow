extends Node2D

var screen : String = "editor"
var keymap : OrderedSet

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_back_pressed():
	get_tree().change_scene_to_file("res://scenes/menu.tscn")


func _on_timing_pressed():
	if screen == "editor":
		var inst = load("res://scenes/timing_menu.tscn").instantiate()
		inst.position = Vector2(1920/2, 1080/2)
		add_child(inst)
		screen = "timing"


func _on_file_dialog_file_selected(path):
	var music = AudioStreamPlayer.new()
	var stream = load(path)
	music.set_stream(stream)
	music.volume_db = 1
	music.pitch_scale = 1
	add_child(music)
	music.add_to_group("songs")
	music.play()
