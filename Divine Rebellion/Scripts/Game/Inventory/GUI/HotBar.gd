extends Panel

@onready var inventory: Inventory = preload("res://Scripts/Game/Inventory/playerInventory.tres")
@onready var slots: Array = $Container.get_children()
@onready var selector: Sprite2D = $Selector
@onready var player = $"../.."
@onready var inv = $"../inventory"

var currently_selected: int = 0
var item = null

func _ready():
	update()
	inventory.updated.connect(update)
	update_equipped_item()

func update() -> void:
	for i in range(slots.size()):
		var inventory_slot: InventorySlot = inventory.slots[i]
		slots[i].update_to_slot(inventory_slot)
		update_equipped_item()
	
func move_selector_left() -> void:
	if !Global.incafe:
		currently_selected = (currently_selected + 1) % slots.size()
		selector.global_position = slots[currently_selected].global_position
		update_equipped_item()

func move_selector_right() -> void:
	if !Global.incafe:
		currently_selected = (currently_selected - 1) % slots.size()
		selector.global_position = slots[currently_selected].global_position
		update_equipped_item()

func _unhandled_input(event) -> void:
	if event.is_action_pressed("move_selector_left"):
		move_selector_left()
	if event.is_action_pressed("move_selector_right"):
		move_selector_right()


func update_equipped_item():
	var selected_slot = inventory.slots[currently_selected]
	
	Global.weapon_equip = false
	Global.tool_equip = false

	if selected_slot.item:
		item = selected_slot.item
		
		if item.itemType == "weapon":
			Global.weapon_equip = true
			if item.name == "Wooden Sword":
				Global.weapon = 0
		elif item.itemType == "tool":
			Global.tool_equip = true
			if item.name == "Wooden Axe":
				Global.tool = 0
			elif item.name == "Wooden Pickaxe":
				Global.tool = 1
			elif item.name == "Wooden Shovel":
				Global.tool = 2
			elif item.name == "Wooden Watering Can":
				Global.tool = 3
		else:
			Global.weapon_equip = false
			Global.tool_equip = false
	else:
		item = null

func _input(event):
	if !Global.incafe:
		if Input.is_key_pressed(KEY_1):
			currently_selected = 0
		if Input.is_key_pressed(KEY_2):
			currently_selected = 1
		if Input.is_key_pressed(KEY_3):
			currently_selected = 2
		if Input.is_key_pressed(KEY_4):
			currently_selected = 3
		if Input.is_key_pressed(KEY_5):
			currently_selected = 4
		if Input.is_key_pressed(KEY_6):
			currently_selected = 5
		if Input.is_key_pressed(KEY_7):
			currently_selected = 6
		if Input.is_key_pressed(KEY_8):
			currently_selected = 7
		if Input.is_key_pressed(KEY_9):
			currently_selected = 8
		if Input.is_key_pressed(KEY_0):
			currently_selected = 9
		selector.global_position = slots[currently_selected].global_position
		update_equipped_item()
	if event.is_action_pressed("use_item"):
		var selected_slot = inventory.slots[currently_selected]
		if selected_slot:
			if selected_slot.item and selected_slot.item.type == "Food":
				if player.currentHealth < player.maxHealth or player.currentMana < player.maxMana:
					player.currentHealth = min(player.maxHealth, player.currentHealth+selected_slot.item.health)
					Global.currentHealth = min(player.maxHealth, player.currentHealth+selected_slot.item.health)
					player.currentMana = min(player.maxMana, player.currentMana+selected_slot.item.energy)
					Global.currentMana = min(player.maxMana, player.currentMana+selected_slot.item.energy)
					player.manaChanged.emit()
					player.healthChanged.emit()
					inv.reduce_item(currently_selected, 1)
					inv.update()
					update()
			else:
				print("тяжело")
