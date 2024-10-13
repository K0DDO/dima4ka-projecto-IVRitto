extends Control

signal opened
signal closed
signal inventory_updated

var is_open = true

@onready var inventory: Inventory = preload("res://Scripts/Game/Inventory/playerInventory.tres")
@onready var ItemStackGuiClass = preload("res://Scenes/Game/GUI/itemsStackGui.tscn")
@onready var slots: Array = $Combat/GridContainer.get_children()
@onready var slots2: Array = $Book/GridContainer.get_children()

var itemInHand: ItemStackGui
var oldIndex: int = -1
var locked: bool = false

func update_slots(slots_array: Array):
	for i in range(min(inventory.slots.size(), slots_array.size())):
		var inventorySlot: InventorySlot = inventory.slots[i]
		
		if !inventorySlot.item:
			slots_array[i].clear()
			continue
		
		var itemStackGui: ItemStackGui = slots_array[i].itemStackGui
		if !itemStackGui:
			itemStackGui = ItemStackGuiClass.instantiate()
			slots_array[i].insert(itemStackGui)
		
		itemStackGui.inventorySlot = inventorySlot
		itemStackGui.update()

func update():
	update_slots(slots)
	update_slots(slots2)
	inventory_updated.emit()
	
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

func open():
	visible = true
	is_open = true
	opened.emit()

func close():
	visible = false
	is_open = false
	closed.emit()
	
func onSlotClicked(slot):
	if locked: return
	if slot.isEmpty():
		handle_empty_slot(slot)
	else:
		handle_filled_slot(slot)

func handle_empty_slot(slot):
	if itemInHand:
		insertItemInSlot(slot)

func handle_filled_slot(slot):
	if !itemInHand:
		takeItemFromSlot(slot)
	elif slot.itemStackGui.inventorySlot.item.name == itemInHand.inventorySlot.item.name:
		stackItems(slot)
	else:
		swapItems(slot)

	
func takeItemFromSlot(slot):
	itemInHand  = slot.takeItem()
	add_child(itemInHand)
	updateItemInHand()
	
	oldIndex = slot.index
	
func insertItemInSlot(slot):
	var item = itemInHand
	
	remove_child(itemInHand)
	itemInHand = null
	
	slot.insert(item)
	oldIndex = -1
	
func swapItems(slot):
	var tempItem = slot.takeItem()
	
	insertItemInSlot(slot)
	
	itemInHand = tempItem
	add_child(itemInHand)
	updateItemInHand()

func stackItems(slot):
	var slotItem: ItemStackGui = slot.itemStackGui
	var maxAmount = slotItem.inventorySlot.item.stackSize
	var totalAmount = slotItem.inventorySlot.amount + itemInHand.inventorySlot.amount
	
	if slotItem.inventorySlot.amount == maxAmount:
		swapItems(slot)
		return
		
	if totalAmount <= maxAmount:
		slotItem.inventorySlot.amount = totalAmount
		remove_child(itemInHand)
		itemInHand = null
		oldIndex = -1
	else:
		slotItem.inventorySlot.amount = maxAmount
		itemInHand.inventorySlot.amount = totalAmount - maxAmount
	
	slotItem.update()
	if itemInHand: itemInHand.update()


func updateItemInHand():
	if !itemInHand: return
	itemInHand.global_position = get_global_mouse_position() - itemInHand.size / 2
	itemInHand.scale = Vector2(0.4, 0.4)
	
func putItemBack():
	locked = true
	if oldIndex < 0:
		var emptySlots = slots.filter(func (s): return s.isEmpty())
		if emptySlots.is_empty(): return
		
		oldIndex = emptySlots[0].index
	
	var targetSlot = slots[oldIndex]
	
	var tween = create_tween()
	var targetPosition = targetSlot.global_position + targetSlot.size / 2 * 0.4
	tween.tween_property(itemInHand, "global_position", targetPosition, 0.2)

	tween.finished.connect(on_put_back_finished)

func on_put_back_finished():
	insertItemInSlot(slots[oldIndex])
	locked = false

func _input(_event):
	if Input.is_action_just_pressed("e"):
		if is_open:
			close()
		else:
			open()
		Global.tabinv = "combat"
	
	if Input.is_action_just_pressed("esc"):
		if is_open:
			close()
			Global.tabinv = "combat"
		else:
			Global.tabinv = "settings"
			open()
		
	if itemInHand && !locked && Input.is_action_just_pressed("rightClick"):
		putItemBack()
	updateItemInHand()

func reduce_item(index: int, amount: int):
	var slot = slots[index]
	if slot.itemStackGui and slot.itemStackGui.inventorySlot:
		slot.itemStackGui.inventorySlot.amount -= amount
		if slot.itemStackGui.inventorySlot.amount <= 0:
			inventory.slots[index].item = null
		update_slots(slots)

func has_item(item_name: String, amount: int) -> bool:
	if not inventory:
		return false

	var total_amount = 0
	for slot in inventory.slots:
		if slot.item and slot.item.name == item_name:
			total_amount += slot.amount

	if total_amount >= amount:
		return true
	return false

func remove_items(item_name: String, amount: int):
	if not inventory:
		return

	for index in range(inventory.slots.size()):
		var slot = inventory.slots[index]
		if slot.item and slot.item.name == item_name:
			if slot.amount <= amount:
				amount -= slot.amount
				slot.item = null  # Удаляем предмет
				slot.amount = 0  # Устанавливаем количество на 0
			else:
				slot.amount -= amount
				break
	update()


