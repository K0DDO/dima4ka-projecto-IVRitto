extends Node2D

@onready var player = $TileMap/Player

func _ready():
	match Global.entry_point:
		Global.EntryPoint.fCtF:
			player.position = Vector2(972, 484)

func _on_inventory_closed():
	get_tree().paused = false

func _on_inventory_opened():
	get_tree().paused = true
