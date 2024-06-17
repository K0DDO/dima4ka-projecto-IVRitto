extends Control

@onready var eyes_color = $EyesColor

func _process(_delta):
	eyes_color.color = Global.eyescolor

func _on_eyes_color_color_changed(color):
	Global.eyescolor = color
