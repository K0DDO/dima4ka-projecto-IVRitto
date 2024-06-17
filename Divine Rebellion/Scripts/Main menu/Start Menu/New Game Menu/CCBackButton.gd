extends Sprite2D

@onready var animations = $BackButtonAnimation

func _on_back_button_pressed():
	$Timer.start()
	animations.play("pressed")

func _on_timer_timeout():
	get_tree().change_scene_to_file("res://Scenes/main_menu.tscn")
	Global.tab = "body"
	Global.bodybutton = 0
	Global.eyescolor = Color(0.369, 0.357, 0.357, 1.0)
	Global.hairbutton = 0
	Global.topbutton = 0
	Global.bottombutton = 0
	Global.bootsbutton = 0
	Global.num = 0
	Global.playername = ""
	Global.haircolor = Color(0.349, 0.196, 0.141, 1.0)
	Global.acccolor = Color(1.0, 0.49, 0.984, 1.0)
	Global.gender = 0
	Global.skill = 0
