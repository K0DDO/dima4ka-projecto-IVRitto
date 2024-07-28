extends Control

signal opened
signal closed

var is_open = true

@onready var inventory: Inventory = preload("res://Scripts/Game/Inventory/playerInventory.tres")
@onready var slots: Array = $Combat/GridContainer.get_children()

func update():
	for i in range(min(inventory.slots.size(), slots.size())):
		slots[i].update(inventory.slots[i])

func _ready():
	inventory.updated.connect(update)
	update()
	close()

func _process(_delta):
	if Input.is_action_just_pressed("e"):
		Global.tabinv = "combat"
		if is_open:
			close()
		else:
			open()

func open():
	visible = true
	is_open = true
	opened.emit()

func close():
	visible = false
	is_open = false
	closed.emit()
