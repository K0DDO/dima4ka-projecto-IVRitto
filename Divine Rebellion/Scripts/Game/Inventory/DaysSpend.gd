extends Label

func _process(delta):
	text = str((Global.year - 1) * 28 * 4 + (Global.season - 1) * 28 + Global.day -1)
