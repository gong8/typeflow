extends Node2D

var top_left = Vector2(80, 0)
var bottom_right = Vector2(1920, 80)
var dragging = false
var bgColor = Color(0, 0, 0)
var offset = 0
var bounds = Rect2(top_left, bottom_right - top_left)
var orig_slider_width = 100
var window_x = orig_slider_width / 2
var zoom = 1.0
var slider_width = orig_slider_width
var slider_height = bottom_right.y - top_left.y
var half_width = slider_width / 2
var scroll_speed = 50
var max_zoom = bounds.size.x / orig_slider_width
var min_zoom = 0.2
var fraction: float = 0.0
var value: float = 0.0

var song: AudioStreamPlayer = null
var song_length: float
var current_time: float
var was_playing: bool = false
var selected_toothpick : Node = null



func _draw():
	draw_rect(bounds, bgColor)
	window_x = max(top_left.x, min(bottom_right.x, window_x))
	draw_rect(Rect2(Vector2(window_x - half_width, top_left.y), Vector2(half_width * 2, slider_height)), Color(1, 1, 1))
	draw_line(Vector2(window_x , top_left.y), Vector2(window_x , slider_height), Color(1, 0, 0), 2)

func _ready():
	$TogglePlay.text = "Play"

func _process(delta):
	print(window_x)
	if song == null:
		song = get_tree().get_first_node_in_group("songs")
		if song == null:
			return
		song_length = song.stream.get_length()
		print(song_length)
		$TogglePlay.text = "Play"
		song.play()
		song.set_stream_paused(true)
		
	if song.is_playing():
		window_x = fraction_to_window_x((song.get_playback_position() / song_length))
	
	slider_width = orig_slider_width * zoom
	slider_height = bottom_right.y - top_left.y
	half_width = slider_width / 2
	max_zoom = bounds.size.x / orig_slider_width
	if Input.is_action_just_pressed("Click"):
		if bounds.has_point(get_local_mouse_position()):
			dragging = true
			drag_started()
			offset = get_global_mouse_position().x - window_x
			if abs(offset) > half_width:
				offset = 0
	if Input.is_action_just_released("ScrollUp"):
		zoom = min(max_zoom, zoom + scroll_speed * delta)
	if Input.is_action_just_released("ScrollDown"):
		zoom = max(min_zoom, zoom - scroll_speed * delta)
	if dragging:
		window_x = get_global_mouse_position().x - offset
	if Input.is_action_just_released("Click"):
		if dragging:
			drag_ended()
		dragging = false
	fraction = window_x_to_fraction(window_x)
	value = fraction * song_length
	queue_redraw()
	
	
func window_x_to_fraction(x: float) -> float:
	return (x - 80.0) / (1920.0 - 80.0)
	
func fraction_to_window_x(x: float) -> float:
	return x * (1920.0 - 80.0) + 80.0

func _on_toggle_play_pressed():
	if song.is_playing():
		song.set_stream_paused(true)
		$TogglePlay.text = "Play"
	else:
		song.set_stream_paused(false)
		$TogglePlay.text = "Pause"

func drag_started():
	was_playing = song.is_playing()
	song.set_stream_paused(true)
	

func drag_ended():
	if was_playing:
		song.play(value)
		$TogglePlay.text = "Pause"
		song.set_stream_paused(false)
	else:
		song.play(value)
		song.set_stream_paused(true)
