extends Control

var is_open = true

func _ready():
	close()

func _process(_delta):
	if Input.is_action_just_pressed("e"):
		Global.tabinv = "combat"
		if is_open:
			close()
		else:
			open()

func open():
	visible = true
	is_open = true

func close():
	visible = false
	is_open = false
