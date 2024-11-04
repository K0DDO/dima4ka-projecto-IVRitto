extends Control

@onready var vbox_container = $ScrollContainer/VBoxContainer
@onready var http_request = $HTTPRequest
@onready var animation = $ColorRect/Animation

var url = "http://127.0.0.1:8000/"
var save_button_scene_path: String = "res://Scenes/Start menu/load Game/SavesButton.tscn"

func _ready():
	if Global.username != "":
		load_saves(Global.username)
	else:
		var save_files = get_save_files()
		generate_save_buttons(save_files)
	animation.play("fade_in")

func another_generate_save_buttons(saves: Array):
	var save_button_scene = load(save_button_scene_path)
	for save in saves:
		var button_instance = save_button_scene.instantiate()
		vbox_container.add_child(button_instance)
		button_instance.set_vars(save)

func _on_http_request_request_completed(_result, _response_code, headers, body):
	var data = JSON.parse_string(body.get_string_from_utf8())
	another_generate_save_buttons(data)

func load_saves(username):
	http_request.request(url+"load_data?username="+username, ["Content-Type: application/json"], HTTPClient.METHOD_GET)

func get_save_files() -> Array:
	var dir = DirAccess.open("user://saves/")
	return dir.get_files()


func generate_save_buttons(save_files: Array):
	var save_button_scene = load(save_button_scene_path)
	for file_name in save_files:
		var file_path = "user://saves/" + file_name
		var file = FileAccess.open(file_path, FileAccess.READ)	
		var save_data = {}
		if file:
			var json_string = file.get_as_text()
			var json = JSON.parse_string(json_string)
			save_data = json
			file.close()
		
		var button_instance = save_button_scene.instantiate()
		vbox_container.add_child(button_instance)
		button_instance.set_vars(save_data)
