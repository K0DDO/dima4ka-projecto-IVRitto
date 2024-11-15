extends Control

@onready var hair_color = $HairColor

func _process(_delta):
	hair_color.color = Global.haircolor

func _on_hair_color_color_changed(color):
	Global.haircolor = color
