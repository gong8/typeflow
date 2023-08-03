extends Node2D

var background = Rect2(Vector2(0, 0), Vector2(1240, 40))
var bar = Rect2(Vector2(20, 16), Vector2(1200, 8))
var value = 0.0
var max_value: float = 100.0
var handle_x: float
var dragging: bool = false

signal drag_started 
signal drag_ended

func _draw():
	draw_rect(background, Color(0.2, 0.2, 0.2))
	draw_rect(bar, Color(0, 0, 0))
	handle_x = bar.position.x + bar.size.x * value / max_value
	var handle_y = bar.position.y + bar.size.y / 2
	draw_circle(Vector2(handle_x, handle_y), bar.size.y * 1.5, Color(1, 1, 1))
	var top_y = handle_y - 16
	var bottom_y = handle_y + 16
	draw_line(Vector2(handle_x, top_y), Vector2(handle_x, bottom_y), Color(1, 0, 0), 2)

func _process(_delta):
	if Input.is_action_just_pressed("Click"):
		if background.has_point(get_local_mouse_position()):
			dragging = true
			drag_started.emit()
	if dragging and Input.is_action_just_released("Click"):
		dragging = false
		drag_ended.emit()
	if dragging:
		value = (get_local_mouse_position().x - bar.position.x) / bar.size.x * max_value
		value = max(0, min(value, max_value))
	queue_redraw()
