extends Area2D

@onready var animation = $"../../Player/CanvasLayer/ColorRect/AnimationPlayer"

func _on_body_entered(body):
	if body.has_method("player"):
		animation.play("fade_out")
		await animation.animation_finished
		$"../../../TimeSystem".change_scene("res://Scenes/Game/world/playerHouse.tscn")
		Global.second = 0
		Global.minute = 0
		Global.hour = 0
		Global.day = 1
		Global.season = 1
		Global.year = 1
		Global.mobdead = 0
		Saves.save_inventory($"../../Player/CanvasLayer/inventory".inventory)
		Saves.save_game(Global.playername)
		
