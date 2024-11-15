extends Button

@export var item: InventoryItem

@onready var backgrounnd_sprite: Sprite2D = $background
@onready var item_texture = $CenterContainer/Panel/Item
@onready var choose = $Choose
@onready var inventory = $"../../.."
@onready var inv: Inventory = preload("res://Scripts/Game/Inventory/playerInventory.tres")

func _ready():
	if item:
		item_texture.texture = item.texture
		_on_inventory_inventory_updated()

func _on_inventory_inventory_updated():
	if can_craft():
		choose.visible = true
	else:
		choose.visible = false

func can_craft() -> bool:
	return inventory.has_item(item.recipe_items[0].name, item.recipe_amounts[0])

func _on_pressed():
	if can_craft():
		inventory.remove_items(item.recipe_items[0].name, item.recipe_amounts[0])
		for i in range(item.carft_amount):
			inv.insert(item)
