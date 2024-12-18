extends Node2D

@onready var player = $TileMap/Player
@export var OreScene: PackedScene = null
@export var StoneScene1: PackedScene = null
@export var StoneScene2: PackedScene = null
@export var StoneScene3: PackedScene = null
@export var StoneScene4: PackedScene = null
@export var CoalScene: PackedScene = null
@export var MobScene: PackedScene = null
@export var GroundTileMap: TileMap = null
@export var spawn_chance = 0.2
@export var mob_spawn_chance = 0.01

func _ready():
	match Global.entry_point:
		Global.EntryPoint.fFtCave:
			player.position = Vector2(200, 278)
		Global.EntryPoint.fCavetF:
			player.position = Vector2(361, 118)
	generate_ores()
	generate_mobs()

func _on_inventory_closed():
	get_tree().paused = false

func _on_inventory_opened():
	get_tree().paused = true

func generate_ores():
	var item_scenes = [OreScene, StoneScene1, StoneScene2, StoneScene3, StoneScene4, CoalScene]

	for cell_position in GroundTileMap.get_used_cells(0):
		if randf() < spawn_chance:
			var selected_scene = item_scenes[randi() % item_scenes.size()]
			var ore_instance = selected_scene.instantiate()
			GroundTileMap.add_child(ore_instance)

			var local_position = GroundTileMap.map_to_local(cell_position) + Vector2(8.0, 8.0)
			ore_instance.position = local_position

func generate_mobs():
	for cell_position in GroundTileMap.get_used_cells(0):
		if randf() < mob_spawn_chance:
			var mob_count = randi() % 2
			for i in range(mob_count):
				var mob_instance = MobScene.instantiate()
				GroundTileMap.add_child(mob_instance)

				var local_position = GroundTileMap.map_to_local(cell_position) + Vector2(randf_range(-8, 8), randf_range(-8, 8))
				mob_instance.position = local_position



