extends Control

var progress = []
var sceneName
var scene_load_status = 0

func _ready():
	sceneName = "res://Scenes/Game/world/playerHouse/player_house_second_floor.tscn"
	ResourceLoader.load_threaded_request(sceneName)
	save_game(Global.playername)
	
func save_game(save_name: String):
	var save_data = {}
	save_data["playername"] = Global.playername
	save_data["player_health"] = Global.currentHealth
	save_data["inventory"] = Global.inventory
	save_data["bodybutton"] = Global.bodybutton
	save_data["eyescolor"] = Global.eyescolor
	save_data["hairbutton"] = Global.hairbutton
	save_data["haircolor"] = Global.haircolor
	save_data["acccolor"] = Global.acccolor
	save_data["topbutton"] = Global.topbutton
	save_data["bottombutton"] = Global.bottombutton
	save_data["bootsbutton"] = Global.bootsbutton
	save_data["gender"] = Global.gender
	save_data["skill"] = Global.skill
	save_data["totalwealth"] = Global.totalwealth
	save_data["currentmoney"] = Global.currentmoney
	save_data["friendship"] = Global.friendship
	save_data["combating"] = Global.combating
	save_data["fishing"] = Global.fishing
	save_data["farming"] = Global.farming
	save_data["collecting"] = Global.collecting
	save_data["magic"] = Global.magic
	save_data["second"] = Global.second
	save_data["minute"] = Global.minute
	save_data["hour"] = Global.hour
	save_data["day"] = Global.day
	save_data["season"] = Global.season
	save_data["year"] = Global.year
	save_data["currentWaterLvl"] = Global.currentWaterLvl
	save_data["currentHealth"] = Global.currentHealth
	save_data["currentMana"] = Global.currentMana
	save_data["incafe"] = Global.incafe
	save_data["got_gold_key"] = Global.got_gold_key
	
	var save_path = "user://saves/" + save_name + ".json"
	
	var dir = DirAccess.open("user://saves/")
	if dir == null:
		DirAccess.make_dir_absolute("user://saves/")
	
	var file = FileAccess.open(save_path, FileAccess.ModeFlags.WRITE)
	if file:
		file.store_string(JSON.stringify(save_data))
		file.close()
		print("засейвил")


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
