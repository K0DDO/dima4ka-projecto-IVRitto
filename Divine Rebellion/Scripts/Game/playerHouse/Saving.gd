extends Area2D

@onready var animation = $"../Player/CanvasLayer/ColorRect/AnimationPlayer"

func _on_body_entered(body):
	if body.has_method("player"):
		Global.entry_point = Global.EntryPoint.STAIRS_FIRST_FLOOR
		animation.play("fade_out")
		await animation.animation_finished
		Global.inventory = $"../Player/CanvasLayer/inventory".slots
		$"../TimeSystem".change_scene("res://Scenes/saving_screen.tscn")
