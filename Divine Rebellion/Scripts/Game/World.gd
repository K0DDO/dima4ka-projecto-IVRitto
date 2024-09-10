extends Node2D

@onready var inventory = $TileMap/Player/CanvasLayer/inventory

func _ready():
	Global.scene = "learning"

func _on_inventory_closed():
	get_tree().paused = false

func _on_inventory_opened():
	get_tree().paused = true
	
