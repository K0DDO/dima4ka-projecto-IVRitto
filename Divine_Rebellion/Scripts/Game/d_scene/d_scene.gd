extends Node2D

@onready var player = $TileMap/Player

func _ready():
	match Global.entry_point:
		Global.EntryPoint.fPtD:
			player.position = Vector2(16, 148)
		Global.EntryPoint.fDtP:
			player.position = Vector2(577, 214)
		Global.EntryPoint.fFtD1:
			player.position = Vector2(168, 22)
		Global.EntryPoint.fFtD2:
			player.position = Vector2(578, 22)
		Global.EntryPoint.fDtF1:
			player.position = Vector2(168, 644)
		Global.EntryPoint.fDtF2:
			player.position = Vector2(529, 648)

func _on_inventory_closed():
	get_tree().paused = false

func _on_inventory_opened():
	get_tree().paused = true
