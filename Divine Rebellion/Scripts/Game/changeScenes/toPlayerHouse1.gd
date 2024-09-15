extends Area2D

var in_zone = false
@onready var animation = $"../../Player/CanvasLayer/ColorRect/AnimationPlayer"

func _on_body_entered(body):
	if body.has_method("player"):
		in_zone = true

func _on_body_exited(body):
	if body.has_method("player"):
		in_zone = false

func _process(_delta):
	if in_zone:
		if Input.is_action_just_pressed("rightClick"):
			Global.entry_point = Global.EntryPoint.STAIRS_FIRST_FLOOR
			animation.play("fade_out")
			await animation.animation_finished
			get_tree().change_scene_to_file("res://Scenes/Game/world/playerHouse/player_house_inside_first_floor.tscn")
