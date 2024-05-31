extends Sprite2D

@onready var animations = $BackButtonAnimation

func _on_back_button_pressed():
	$Timer.start()
	animations.play("pressed")

func _on_timer_timeout():
	get_tree().change_scene_to_file("res://Scenes/main_menu.tscn")

func _input(_event):
	if Input.is_key_pressed(KEY_ESCAPE):
		get_tree().change_scene_to_file("res://Scenes/main_menu.tscn")
