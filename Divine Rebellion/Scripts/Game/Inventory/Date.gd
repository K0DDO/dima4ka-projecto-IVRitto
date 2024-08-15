extends Label

func _process(delta):
	text = ""
	if Global.day < 10:
		text += "0" + str(Global.day) + "." + "0" + str(Global.season) + "." 
	else:
		text += "0" + str(Global.day) + "." + "0" + str(Global.season) + "." 
	if Global.year < 10:
		text += "0" + str(Global.year)
	else:
		text += str(Global.year)
