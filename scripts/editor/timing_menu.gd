extends Node2D

var song: AudioStreamPlayer = null
var song_length: float
var current_time: float
var was_playing: bool = false
var selected_toothpick : Node = null

func _process(delta):
	if song == null:
		song = get_tree().get_first_node_in_group("timing_songs")
		if song == null:
			return
		song_length = song.stream.get_length()
		print(song_length)
		$TimingTimeline.max_value = song_length
		$TogglePlay.text = "Play"
		song.play()
		song.set_stream_paused(true)
	
	if Global.root.map_manager.changes.size() == 0:
		$JumpToLastTP.visible = false
	else:
		$JumpToLastTP.visible = true
		
	if song.is_playing():
		$TimingTimeline.value = song.get_playback_position()
	
	if selected_toothpick == null:
		$SelectedTPMenu.visible = false
	else:
		$SelectedTPMenu.visible = true

func _on_drag_started():
	was_playing = song.is_playing()
	song.set_stream_paused(true)


func _on_drag_ended():
	if was_playing:
		song.play($TimingTimeline.value)
		$TogglePlay.text = "Pause"
	else:
		song.play($TimingTimeline.value)
		song.set_stream_paused(true)

func _on_close_pressed():
	Global.screen = "editor"
	visible = false

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
	
	var properties = Global.root.map_manager.get_last_properties($TimingTimeline.value)
	toothpick_inst.bpm = properties["bpm"]
	toothpick_inst.tracks = properties["tracks"]
	
	if Global.root.map_manager.changes.size() == 0:
		toothpick_inst.id = 0
		Global.root.map_manager.changes[0] = {}
	else:
		var index = Global.root.map_manager.changes.keys()[-1] + 1
		toothpick_inst.id =  index
		Global.root.map_manager.changes[index] = {}
	
	toothpick_inst.max_value = $TimingTimeline.max_value
	toothpick_inst.set_value($TimingTimeline.value)
	toothpick_inst.update_properties()
	
	selected_toothpick = toothpick_inst
	update_vals()

func _on_delete_toothpick_pressed():
	Global.root.map_manager.changes.erase(selected_toothpick.id)
	selected_toothpick.queue_free()

func update_vals():
	$SelectedTPMenu/TimeEdit.text = str(selected_toothpick.value)
	$SelectedTPMenu/BPMEdit.text = str(selected_toothpick.bpm)
	$SelectedTPMenu/TrackEdit.text = str(selected_toothpick.tracks)


func _on_time_edit_text_changed():
	if $SelectedTPMenu/TimeEdit.text.is_valid_float():
		selected_toothpick.set_value(float($SelectedTPMenu/TimeEdit.text))

func _on_time_edit_focus_exited():
	if selected_toothpick != null:
		update_vals()
	
func _on_bpm_edit_focus_exited():
	var text = $SelectedTPMenu/BPMEdit.text
	if text.is_valid_int() && int(text) > 0:
		selected_toothpick.bpm = int(text)
		
	if selected_toothpick != null:
		selected_toothpick.update_properties()
		update_vals()

func _on_track_edit_focus_exited():
	var text =  $SelectedTPMenu/TrackEdit.text
	if text.is_valid_int() && int(text) > 0:
		selected_toothpick.tracks = int(text)
	
	if selected_toothpick != null:
		selected_toothpick.update_properties()
		update_vals()


func _on_jump_to_last_tp_pressed():
	pass
