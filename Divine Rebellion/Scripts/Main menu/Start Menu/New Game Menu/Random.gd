extends TextureButton

func _pressed():
	Global.bodybutton = randi() % 9
	Global.eyescolor = Color(randf(), randf(), randf(), 1.0)
	Global.hairbutton = randi() % 18
	Global.haircolor = Color(randf(), randf(), randf(), 1.0)
	Global.acccolor = Color(randf(), randf(), randf(), 1.0)
	Global.topbutton = randi() % 7
	Global.bottombutton = randi() % 5
	Global.bootsbutton = randi() % 3
	Global.skill = randi() % 6
	position.y += 1
	await get_tree().create_timer(0.1).timeout
	position.y -= 1
