extends Button

@onready var username = $"../Username"

func _ready():
	username.text = Global.username

func _on_pressed():
	get_tree().change_scene_to_file("res://Scenes/logIn.tscn")
