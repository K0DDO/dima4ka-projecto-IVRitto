extends Area2D

var in_zone = false
@onready var animation = $"../../../Player/CanvasLayer/ColorRect/AnimationPlayer"
@onready var tile_map = $"../../.."
var pressed = false

func _on_body_entered(body):
	if body.has_method("player"):
		in_zone = true

func _on_body_exited(body):
	if body.has_method("player"):
		in_zone = false

func _input(_event):
	if in_zone:
		if Input.is_action_just_pressed("rightClick") and !pressed:
			pressed = true
			TileMapSave.save_tilemap(tile_map)
			Global.entry_point = Global.EntryPoint.DOOR
			animation.play("fade_out")
			await animation.animation_finished
			$"../../../../TimeSystem".change_scene("res://Scenes/Game/world/playerHouse/player_house_inside_first_floor.tscn")
