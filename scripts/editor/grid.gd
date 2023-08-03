extends Node2D

var factor: float = 1.0
var zoom: float = 1.0
var color: Color = Color(0, 0, 0)
var window: Vector2 = Vector2(1920, 1080-160)
const width: int = 2
const UPPER_X: int = 1000000
const tracks: int = 5

func _draw():
	var col_size: float = window.x / 5 / factor * zoom
	var row_size: float = window.y / tracks
	assert(col_size > 1e-6, "Column width must be more than zero")
	for i in range(0, UPPER_X + 1, col_size):
		draw_line(Vector2(i, 0), Vector2(i, window.y), color, width)
	for i in range(0, window.y + 1, row_size):
		draw_line(Vector2(0, i), Vector2(window.x, i), color, width)

func _process(_delta):
	queue_redraw()
