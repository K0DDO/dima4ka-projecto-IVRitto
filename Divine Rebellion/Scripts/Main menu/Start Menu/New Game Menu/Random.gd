extends TextureButton

func _pressed():
	Global.bodybutton = randi() % 9
	Global.eyebutton = randi() % 8
	Global.hairbutton = randi() % 18
	Global.haircolor = Color(randf(), randf(), randf(), 1.0)
	Global.topbutton = randi() % 7
	Global.bottombutton = randi() % 5
	Global.bootsbutton = randi() % 3
	Global.skill = randi() % 6
