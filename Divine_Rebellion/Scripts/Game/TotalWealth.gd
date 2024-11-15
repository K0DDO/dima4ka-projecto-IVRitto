extends Label

func _ready():
	text = str(Global.totalwealth)

func _process(_delta):
	text = str(Global.totalwealth)
