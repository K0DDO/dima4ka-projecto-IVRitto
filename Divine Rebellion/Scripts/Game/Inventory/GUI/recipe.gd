extends HBoxContainer
 
@onready var craft = $Button
@export var item: InventoryItem
@onready var recipe = item.recipe
 
func _ready():
	craft.icon = item.texture
 
	for i in range(recipe.size()):
		get_child(i).item = recipe[i]
 
func check():
	var flag = []
 
	for i in range(recipe.size()):
		flag.append(get_child(i).check())
 
	if false not in flag:
		craft.disabled = false
 
 
func _on_craft_pressed():
	craft.disabled = true
	var inventory = get_tree().current_scene.find_child("Inventory")
 
	for i in recipe:
		inventory.remove_item(i)
	inventory.add_item(item)
