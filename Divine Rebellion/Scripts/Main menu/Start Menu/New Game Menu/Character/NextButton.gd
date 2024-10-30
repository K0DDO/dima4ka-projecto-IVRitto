extends Sprite2D

@onready var animations = $Animation

func _on_next_button_pressed():
	animations.play("pressed")
	if Global.skill == 0:
		Global.friendship = 1
	elif Global.skill == 1:
		Global.combating = 1
	elif Global.skill == 2:
		Global.fishing = 1
	elif Global.skill == 3:
		Global.farming = 1
	elif Global.skill == 4:
		Global.collecting = 1
	elif Global.skill == 5:
		Global.magic = 1
	await get_tree().create_timer(0.2).timeout
	if Global.playername != "":
		var loadingScreen = load("res://Scenes/loading_screen.tscn")
		save_game(Global.playername)
		get_tree().change_scene_to_packed(loadingScreen)

func save_game(character_name: String):
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
	
	var base_save_path = "user://saves/" + character_name + ".json"
	var save_path = base_save_path
	var suffix = 1
	while FileAccess.file_exists(save_path):
		save_path = "user://saves/" + character_name + " (" + str(suffix) + ").json"
		suffix += 1
	Global.savename = character_name + "(" + str(suffix) + ")"
	var dir = DirAccess.open("user://saves/")
	if dir == null:
		DirAccess.make_dir_absolute("user://saves/")
	
	var file = FileAccess.open(save_path, FileAccess.ModeFlags.WRITE)
	if file:
		file.store_string(JSON.stringify(save_data))
		file.close()

