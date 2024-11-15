extends Area2D

@onready var animation = $"../../Player/CanvasLayer/ColorRect/AnimationPlayer"

func _on_body_entered(body):
	if body.has_method("player"):
		animation.play("fade_out")
		await animation.animation_finished
		$"../../TimeSystem".change_scene("res://Scenes/Game/world/playerHouse.tscn")
