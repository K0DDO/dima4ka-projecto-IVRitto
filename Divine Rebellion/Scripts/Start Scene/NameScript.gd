extends Sprite2D

func _on_timer_timeout():
	get_tree().change_scene_to_file("res://Scenes/main_menu.tscn")

func _input(event):
	if event is InputEventMouseButton:
		get_tree().change_scene_to_file("res://Scenes/main_menu.tscn")
