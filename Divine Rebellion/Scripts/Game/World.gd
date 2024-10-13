extends Node2D

@onready var inventory = $TileMap/Player/CanvasLayer/inventory

func _ready():
	Global.hour = 0
	 
func _process(delta):
	pass

func _on_inventory_closed():
	get_tree().paused = false

func _on_inventory_opened():
	get_tree().paused = true
	
