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

func _draw():
	draw_rect(bounds, bgColor)
	window_x = max(top_left.x + half_width, min(bottom_right.x - half_width, window_x))
	draw_rect(Rect2(Vector2(window_x - half_width, top_left.y), Vector2(half_width * 2, slider_height)), Color(1, 1, 1))

func _process(delta):
	slider_width = orig_slider_width * zoom
	slider_height = bottom_right.y - top_left.y
	half_width = slider_width / 2
	max_zoom = bounds.size.x / orig_slider_width
	if Input.is_action_just_pressed("Click"):
		if bounds.has_point(get_local_mouse_position()):
			dragging = true
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
		dragging = false
	queue_redraw()

func _on_toggle_play_pressed():
	pass # Replace with function body.
