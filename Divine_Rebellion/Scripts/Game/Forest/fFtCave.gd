extends Area2D

@onready var animation = $"../TileMap/Player/CanvasLayer/ColorRect/AnimationPlayer"
@onready var tile_map = $"../TileMap"

func _on_body_entered(body):
	if body.has_method("player"):
		TileMapSave.save_tilemap(tile_map)
		Global.entry_point = Global.EntryPoint.fFtCave
		animation.play("fade_out")
		await animation.animation_finished
		$"../TimeSystem".change_scene("res://Scenes/Game/world/Forest/cave.tscn")
