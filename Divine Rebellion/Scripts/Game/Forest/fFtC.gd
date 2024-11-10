extends Area2D

@onready var animation = $"../TileMap/Player/CanvasLayer/ColorRect/AnimationPlayer"
@onready var tile_map = $"../TileMap"
@onready var time_system = $"../TimeSystem"

var in_zone = false

func _input(_event):
	if in_zone and 7 <= time_system.date_time.hours and time_system.date_time.hours < 18:
		if Input.is_action_just_pressed("rightClick"):
				Global.entry_point = Global.EntryPoint.fFtC
				TileMapSave.save_tilemap(tile_map)
				animation.play("fade_out")
				await animation.animation_finished
				$"../TimeSystem".change_scene("res://Scenes/Game/world/Forest/Cafe/cafe.tscn")

func _on_body_entered(body):
	if body.has_method("player"):
		in_zone = true

func _on_body_exited(body):
	if body.has_method("player"):
		in_zone = false
