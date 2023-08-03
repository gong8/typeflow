extends Node2D

var song: AudioStreamPlayer
var song_length: float
var current_time: float

func _ready():
	song = get_tree().get_first_node_in_group("songs")
	print(song)
	song_length = song.stream.get_length()
	print(song_length)
	$HSlider.min_value = 0
	$HSlider.max_value = song_length
	$TogglePlay.text = "Pause"
	

func _process(delta):
	if song.is_playing():
		$HSlider.value = song.get_playback_position()



func _on_drag_started():
	song.set_stream_paused(true)


func _on_drag_ended(value_changed):
	song.play($HSlider.value)
	$TogglePlay.text = "Pause"


func _on_toggle_play_pressed():
	if song.is_playing():
		song.set_stream_paused(true)
		$TogglePlay.text = "Play"
	else:
		song.set_stream_paused(false)
		$TogglePlay.text = "Pause"


func _on_add_toothpick_pressed():
	var toothpick_inst = load("res://scenes/toothpick.tscn").instantiate()
	add_child(toothpick_inst)
	toothpick_inst.max_value = $HSlider.max_value
	toothpick_inst.set_value($HSlider.value)
	
	
