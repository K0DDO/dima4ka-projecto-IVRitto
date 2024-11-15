extends Area2D

signal show
signal hide

var in_zone = false
@onready var animation = $"../ColorRect3/AnimationPlayer"
@onready var global_animation = $"../Player/CanvasLayer/ColorRect/AnimationPlayer"

func _on_body_entered(body):
	if body.has_method("player"):
		in_zone = true
		show.emit()

func _on_body_exited(body):
	if body.has_method("player"):
		in_zone = false
		hide.emit()

func _on_hide():
	animation.play("fade_out")

func _on_show():
	animation.play("fade_in")

func _on_button_up_pressed():
	if in_zone:
		global_animation.play("fade_out")
		await global_animation.animation_finished
		$"../TimeSystem".change_scene("res://Scenes/Game/world/playerHouse/player_house_second_floor.tscn")

func _on_button_down_pressed():
	if in_zone:
		global_animation.play("fade_out")
		await global_animation.animation_finished
		$"../TimeSystem".change_scene("res://Scenes/Game/world/playerHouse/player_house_zero_floor.tscn")
