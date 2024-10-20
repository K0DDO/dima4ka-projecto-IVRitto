extends Control

@export var player : Player

@onready var no_water = $"No Water"
@onready var no_mana = $"No Mana"

func _ready():
	no_mana.visible = false
	no_water.visible = false

func _on_player_mana_changed():
	if Global.currentMana <= 0:
		showNotification(no_mana)

func _on_player_house_water_changed():
	if Global.currentWaterLvl <= 0:
		showNotification(no_water)

func showNotification(message):
	message.visible = true
	await get_tree().create_timer(2).timeout
	message.visible = false
