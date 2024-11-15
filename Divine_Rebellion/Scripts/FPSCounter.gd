extends Label

func _process(_delta):
	if SaveSettingsData.show_fps:
		visible = true
		var fps = Engine.get_frames_per_second()
		text = "FPS: " + str(fps)
	else:
		visible = false
