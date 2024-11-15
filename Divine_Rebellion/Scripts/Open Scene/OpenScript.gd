extends Node2D

signal end_of_animation
signal start_of_animation

@onready var transition = $Transition
@onready var main_menu = preload("res://Scenes/start_scene.tscn")
@onready var new_game_menu = preload("res://Scenes/Start menu/new_game_menu.tscn")

func _ready():
	check_and_set_screen_mode()
	start_of_animation.emit()
	await get_tree().create_timer(3.35).timeout
	end_of_animation.emit()
	transition.play("fade_out")

func _on_transition_animation_finished(_anim_name):
	get_tree().change_scene_to_packed(main_menu)

func check_and_set_screen_mode():
	var screen_size = DisplayServer.window_get_size()
	var aspect_ratio = float(screen_size.x) / float(screen_size.y)
	if aspect_ratio == 16.0 / 9.0 or aspect_ratio == 16.0 / 10.0:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
		SaveSettingsData.full_screen = true
	else:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
		DisplayServer.window_set_size(Vector2i(1920, 1080))
		SaveSettingsData.full_screen = false

