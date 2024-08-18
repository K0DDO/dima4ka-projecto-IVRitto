extends Label

func _process(_delta):
	text = ""
	if Global.day < 10:
		text += "0" + str(Global.day) + "." + "0" + str(Global.season + 1) + "." 
	else:
		text += str(Global.day) + "." + "0" + str(Global.season + 1) + "." 
	if Global.year < 10:
		text += "0" + str(Global.year)
	else:
		text += str(Global.year)
