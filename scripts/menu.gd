extends Node2D

var root



func _on_game_button_pressed():
	get_tree().change_scene_to_file("res://scenes/game.tscn")


func _on_edit_button_pressed():
	get_tree().change_scene_to_file("res://scenes/editor.tscn")
