extends Control

var save_button_scene_path: String = "res://Scenes/Start menu/load Game/SavesButton.tscn"
@onready var vbox_container = $ScrollContainer/VBoxContainer

func _ready():
	var save_files = get_save_files()
	generate_save_buttons(save_files)

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
