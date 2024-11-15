extends Control

@onready var no_water = $"No Water"
@onready var no_mana = $"No Energy"
@onready var you_cannot_enter = $"You cannot enter"
@onready var locked = $Locked

func _ready():
	no_mana.visible = false
	no_water.visible = false
	you_cannot_enter.visible = false
	
func _on_player_mana_changed():
	if Global.currentMana <= 0:
		showNotification(no_mana)

func _on_player_house_water_changed():
	if Global.currentWaterLvl <= 0:
		showNotification(no_water)

func showNotification(message: NinePatchRect):
	message.modulate.a = 0
	message.visible = true

	for i in range(128):
		message.modulate.a = i / 127.0
		await get_tree().create_timer(0.0001).timeout

	await get_tree().create_timer(1).timeout

	for i in range(128):
		message.modulate.a = (127 - i) / 127.0
		await get_tree().create_timer(0.0001).timeout

	message.visible = false

