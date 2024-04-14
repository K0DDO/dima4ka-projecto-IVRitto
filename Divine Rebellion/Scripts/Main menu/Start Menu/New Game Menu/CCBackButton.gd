extends Sprite2D

@onready var animations = $BackButtonAnimation

func _on_back_button_pressed():
	$Timer.start()
	animations.play("pressed")

func _on_timer_timeout():
	get_tree().change_scene_to_file("res://Scenes/main_menu.tscn")
	Global.tab = "body"
	Global.bodybutton = 1
	Global.eyebutton = 1
	Global.hairbutton = 1
	Global.haircolorbutton = 1
	Global.topbutton = 1
	Global.bottombutton = 1
	Global.bootsbutton = 1
	Global.num = 0
