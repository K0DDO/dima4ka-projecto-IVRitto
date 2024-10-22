extends Control

@onready var energy = $Energy
@onready var inv: Inventory = preload("res://Scripts/Game/Inventory/playerInventory.tres")
@export var inventory: Inventory
@onready var cmb1 = $ScrollContainer/VBoxContainer/CafeMenuButton
@onready var cmb2 = $ScrollContainer/VBoxContainer/CafeMenuButton2
@onready var cmb3 = $ScrollContainer/VBoxContainer/CafeMenuButton3
@onready var cmb4 = $ScrollContainer/VBoxContainer/CafeMenuButton4

func _process(_delta):
	energy.text = str(Global.currentMana)

func open():
	visible = true
	Global.incafe = true
	
func close():
	visible = false
	await get_tree().create_timer(0.5).timeout
	Global.incafe = false

func _input(event):
	if Input.is_action_just_pressed("e") or Input.is_action_just_pressed("esc"):
		close()

func buy(resource: food):
	if Global.currentmoney >= resource.cost:
		Global.currentmoney -= resource.cost
		inv.insert(resource.item)

func _on_cafe_menu_button_pressed():
	buy(cmb1.resource)

func _on_cafe_menu_button_2_pressed():
	buy(cmb2.resource)

func _on_cafe_menu_button_3_pressed():
	buy(cmb3.resource)

func _on_cafe_menu_button_4_pressed():
	buy(cmb4.resource)


