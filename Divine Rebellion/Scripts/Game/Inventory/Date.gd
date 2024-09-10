extends Label

func _ready():
	text = ""

	var day = Global.day
	if day < 1:
		Global.day = 1
		day = 1
	if day < 10:
		text += "0" + str(day) + "."
	else:
		text += str(day) + "."

	var season = Global.season
	if season < 1:
		Global.season = 1
		season = 1
	if season < 10:
		text += "0" + str(season) + "."
	else:
		text += str(season) + "."

	var year = Global.year
	if year < 1:
		Global.year = 1
		year = 1
	if year < 10:
		text += "0" + str(year)
	else:
		text += str(year)

func _process(_delta):
	text = ""

	var day = Global.day
	if day < 1:
		Global.day = 1
		day = 1
	if day < 10:
		text += "0" + str(day) + "."
	else:
		text += str(day) + "."

	var season = Global.season
	if season < 1:
		Global.season = 1
		season = 1
	if season < 10:
		text += "0" + str(season) + "."
	else:
		text += str(season) + "."

	var year = Global.year
	if year < 1:
		Global.year = 1
		year = 1
	if year < 10:
		text += "0" + str(year)
	else:
		text += str(year)


