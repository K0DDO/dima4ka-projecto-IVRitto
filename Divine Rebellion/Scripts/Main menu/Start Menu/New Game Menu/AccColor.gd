extends Control

@onready var acc_color = $AccColor

func _process(_delta):
	acc_color.color = Global.acccolor


func _on_acc_color_color_changed(color):
	Global.acccolor = color
