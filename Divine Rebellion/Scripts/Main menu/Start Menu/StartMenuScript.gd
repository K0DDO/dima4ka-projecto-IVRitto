extends Node2D

func _input(_event):
	if Input.is_key_pressed(KEY_ESCAPE):
		get_tree().change_scene_to_file("res://Scenes/main_menu.tscn")
