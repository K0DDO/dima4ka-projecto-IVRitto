extends Panel

@onready var backgroundSprite: Sprite2D = $background
@onready var itemSprite: Sprite2D = $CenterContainer/Panel/item
@onready var amountLabel: Label = $CenterContainer/Panel/Label


func update(slot: InventorySlot):
	if !slot.item:
		itemSprite.visible = false
		amountLabel.visible = false
	elif (slot.amount == 1):
		itemSprite.visible = true
		itemSprite.texture = slot.item.texture
	else:
		itemSprite.visible = true
		itemSprite.texture = slot.item.texture
		amountLabel.visible = true
		amountLabel.text = str(slot.amount)
