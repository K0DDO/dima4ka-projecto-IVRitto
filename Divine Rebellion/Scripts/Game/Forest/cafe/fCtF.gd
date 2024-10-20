extends Area2D

@onready var animation = $"../TileMap/Player/CanvasLayer/ColorRect/AnimationPlayer"

func _on_body_entered(body):
	if body.has_method("player"):
		Global.entry_point = Global.EntryPoint.fCtF
		animation.play("fade_out")
		await animation.animation_finished
		$"../TimeSystem".change_scene("res://Scenes/Game/world/Forest.tscn")
