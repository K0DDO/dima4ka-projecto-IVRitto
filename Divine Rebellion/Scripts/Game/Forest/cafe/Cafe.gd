extends Node2D

@onready var player = $TileMap/Player
@onready var time_system = $TimeSystem
@onready var tile_map = $TileMap

@export var npc_scene: PackedScene
@onready var task = $"TileMap/Player/CanvasLayer/Tasks menu"

var spawned = false

func _ready():
	task.visible = Global.taskv
	if (time_system.date_time.hours == 7 and time_system.date_time.minutes >= 30) or (time_system.date_time.hours >= 8):
		print("spawn")
		spawn_npc2()
		spawned = true
	match Global.entry_point:
		Global.EntryPoint.fCtF:
			player.position = Vector2(972, 484)

func _on_inventory_closed():
	get_tree().paused = false

func _on_inventory_opened():
	get_tree().paused = true

func _process(delta: float) -> void:
	if time_system.date_time.hours == 7 and time_system.date_time.minutes == 30 and !spawned:
		print("spawn")
		spawn_npc()
		spawned = true

func spawn_npc():
	if tile_map and npc_scene:
		var npc_instance = npc_scene.instantiate()
		npc_instance.position = Vector2(404, 428)
		tile_map.add_child(npc_instance)
		npc_instance.target = $Marker2D
		if npc_instance.global_position.distance_to(npc_instance.target.global_position) < npc_instance.target_reach_distance:
			npc_instance.queue_free()

func spawn_npc2():
	if tile_map and npc_scene:
		var npc_instance = npc_scene.instantiate()
		npc_instance.position = Vector2(443, 394)
		tile_map.add_child(npc_instance)
		npc_instance.target = null

