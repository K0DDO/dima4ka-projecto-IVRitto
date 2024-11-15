extends Sprite2D

@onready var http_request = $"../../HTTPRequest"
@onready var animations = $Animation

var url = "http://127.0.0.1:8000/"
var loadingScreen = load("res://Scenes/loading_screen.tscn")


func _ready():
	Global.bodybutton = 0
	Global.eyescolor = Color(0.369, 0.357, 0.357, 1.0)
	Global.hairbutton = 0
	Global.haircolor = Color(0.349, 0.196, 0.141, 1.0)
	Global.acccolor = Color(1.0, 0.49, 0.984, 1.0)
	Global.topbutton = 0
	Global.bottombutton = 0
	Global.bootsbutton = 0
	Global.num = 0
	Global.gender = 0
	Global.skill = 0
	Global.currentHealth = Global.maxHealth
	Global.currentMana = Global.maxMana
	Global.totalwealth = 500
	Global.currentmoney = 500
	initialize_inventory()

func initialize_inventory():
	Global.inventory = []
	for i in range(30):
		var item_data = {
			"name": "",
			"amount": 0,
			"slot_index": i
		}
		Global.inventory.append(item_data)

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
	if Global.username != "":
		http_request.request(url+"save_data/"+Global.username, ["Content-Type: application/json"], HTTPClient.METHOD_PUT, JSON.stringify(Saves.another_save_game(Global.playername)))
	else:
		Saves.save_game(Global.playername)
		get_tree().change_scene_to_packed(loadingScreen)

func _on_http_request_request_completed(_result, _response_code, _headers, _body):
	get_tree().change_scene_to_packed(loadingScreen)
