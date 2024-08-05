extends Control

signal opened
signal closed

var is_open = true

@onready var inventory: Inventory = preload("res://Scripts/Game/Inventory/playerInventory.tres")
@onready var ItemStackGuiClass = preload("res://Scenes/Game/GUI/itemsStackGui.tscn")
@onready var slots: Array = $Combat/GridContainer.get_children()

var itemInHand: ItemStackGui

func update():
	for i in range(min(inventory.slots.size(), slots.size())):
		var inventorySlot: InventorySlot = inventory.slots[i]
		
		if !inventorySlot.item: continue
		
		var itemStackGui: ItemStackGui = slots[i].itemStackGui
		if !itemStackGui:
			itemStackGui = ItemStackGuiClass.instantiate()
			slots[i].insert(itemStackGui)
		
		itemStackGui.inventorySlot = inventorySlot
		itemStackGui.update()

func _ready():
	connectSlots()
	inventory.updated.connect(update)
	update()
	close()
	
func connectSlots():
	for i in range(slots.size()):
		var slot = slots[i]
		slot.index = i
		
		var callable = Callable(onSlotClicked)
		callable = callable.bind(slot)
		slot.pressed.connect(callable)

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
	
func onSlotClicked(slot):
	if slot.isEmpty() && itemInHand:
		insertItemInSlot(slot)
		return
		
	if !itemInHand:
		takeItemFromSlot(slot)
	
func takeItemFromSlot(slot):
	itemInHand  = slot.takeItem()
	add_child(itemInHand)
	updateItemInHand()
	

func insertItemInSlot(slot):
	var item = itemInHand
	
	remove_child(itemInHand)
	itemInHand = null
	
	slot.insert(item)

func updateItemInHand():
	if !itemInHand: return
	itemInHand.global_position = get_global_mouse_position() - itemInHand.size / 2
	itemInHand.scale = Vector2(0.4, 0.4)
	
func _input(event):
	updateItemInHand()
