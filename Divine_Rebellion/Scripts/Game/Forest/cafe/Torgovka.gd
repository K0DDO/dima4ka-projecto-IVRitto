extends StaticBody2D

@onready var area_2d = $Area2D
@onready var cafe_menu = $"../../TileMap/Player/CanvasLayer/CafeMenu"

var in_zone = false

func _input(_event):
	if in_zone:
		if Input.is_action_just_pressed("rightClick"):
			cafe_menu.visible = true
			Global.incafe = true

func _on_area_2d_body_entered(_body):
	in_zone = true

func _on_area_2d_body_exited(_body):
	in_zone = false
	cafe_menu.visible = false
	Global.incafe = false
