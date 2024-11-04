extends Control

var progress = []
var sceneName
var scene_load_status = 0
var url = "http://127.0.0.1:8000/"

@onready var http_request = $"../HTTPRequest"

func _ready():
	sceneName = "res://Scenes/Game/world/playerHouse/player_house_second_floor.tscn"
	ResourceLoader.load_threaded_request(sceneName)
	Saves.save_game(Global.playername)

func _process(_delta):
	scene_load_status = ResourceLoader.load_threaded_get_status(sceneName, progress)
	$Label2.text = str(floor(progress[0]*100)) + "%"
	if scene_load_status == ResourceLoader.THREAD_LOAD_LOADED:
		var newScene = ResourceLoader.load_threaded_get(sceneName)
		$Label2.visible = false
		$Label.visible = false
		$Label3.visible = true
		if Global.username != "":
			http_request.request(url+"save_data/"+Global.username, ["Content-Type: application/json"], HTTPClient.METHOD_PUT, JSON.stringify(Saves.another_save_game(Global.playername)))
		else:
			Saves.save_game(Global.playername)
		await  get_tree().create_timer(2).timeout
		get_tree().change_scene_to_packed(newScene)
