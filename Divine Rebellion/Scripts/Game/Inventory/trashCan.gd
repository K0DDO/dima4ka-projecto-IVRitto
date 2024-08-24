extends TextureButton

@onready var trash_can = $trashCanSprite
@onready var inventory_control = $"../.."

func _on_pressed():
	if inventory_control.itemInHand:
		inventory_control.itemInHand.queue_free()
		inventory_control.itemInHand = null

func _on_mouse_entered():
	trash_can.frame = 1

func _on_mouse_exited():
	trash_can.frame = 0
