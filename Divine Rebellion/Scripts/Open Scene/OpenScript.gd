extends Node2D

@onready var transition = $Transition
@onready var main_menu = preload("res://Scenes/start_scene.tscn")
@onready var new_game_menu = preload("res://Scenes/Start menu/new_game_menu.tscn")	

func _ready():
	await get_tree().create_timer(3.35).timeout
	transition.play("fade_out")

func _on_transition_animation_finished(_anim_name):
	get_tree().change_scene_to_packed(main_menu)
	
