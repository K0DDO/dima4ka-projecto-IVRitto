extends Node2D

@onready var inventory = $Player/CanvasLayer/inventory

func _on_inventory_closed():
	get_tree().paused = false

func _on_inventory_opened():
	get_tree().paused = true
	
