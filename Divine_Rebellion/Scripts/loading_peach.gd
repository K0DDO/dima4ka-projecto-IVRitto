extends Control

var progress = []
var sceneName
var scene_load_status = 0

func _ready():
	sceneName = "res://Scenes/Game/game.tscn"
	ResourceLoader.load_threaded_request(sceneName)

func _process(_delta):
	scene_load_status = ResourceLoader.load_threaded_get_status(sceneName, progress)
	$Label2.text = str(floor(progress[0]*100)) + "%"
	if scene_load_status == ResourceLoader.THREAD_LOAD_LOADED:
		var newScene = ResourceLoader.load_threaded_get(sceneName)
		$Label2.visible = false
		$Label.visible = false
		$Label3.visible = true
		await  get_tree().create_timer(2).timeout
		get_tree().change_scene_to_packed(newScene)
