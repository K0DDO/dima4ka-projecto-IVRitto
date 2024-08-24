extends Resource

class_name Inventory

signal updated

@export var slots: Array[InventorySlot]

func insert(item: InventoryItem) -> bool:
	for slot in slots:
		if slot.item == item:
			if slot.amount < slot.item.stackSize:
				slot.amount += 1
				updated.emit()
				return true
	
	for i in range(slots.size()):
		if !slots[i].item:
			slots[i].item = item
			slots[i].amount = 1
			updated.emit()
			return true
	
	return false

func can_insert_item(item: InventoryItem) -> bool:
	for slot in slots:
		if slot.item == item and slot.amount < slot.item.stackSize:
			return true
	
	for i in range(slots.size()):
		if !slots[i].item:
			return true
	
	return false

func removeSlot(inventorySlot: InventorySlot):
	var index  = slots.find(inventorySlot)
	if index < 0: return
	
	remove_at_index(index)

	
func remove_at_index(index: int) -> void:
	slots[index] = InventorySlot.new()
	updated.emit()
	
func insertSlot(index: int, inventorySlot: InventorySlot):
	slots[index] = inventorySlot
	updated.emit()
	
func use_item_at_index(index: int) -> void:
	if index < 0 || index >= slots.size() || !slots[index].item: return
	
	var slot = slots[index]
	
	if slot.amount > 1:
		slot.amount -= 1
		updated.emit()
		return

	remove_at_index(index)
