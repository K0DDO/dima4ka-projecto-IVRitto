extends Node2D

@onready var inventory = $TileMap/Player/CanvasLayer/inventory
@onready var tile_map = $TileMap
@onready var player = $TileMap/Player
@onready var hot_bar = $TileMap/Player/CanvasLayer/HotBar

var can_dig_custom_data = "can_dig"
var can_plant_seed_custom_data = "can_plant_seed"
var can_be_fertilizered_custom_data1 = "can_be_fertilizered1"
var can_be_fertilizered_custom_data2 = "can_be_fertilizered2"
var can_be_fertilizered_custom_data3 = "can_be_fertilizered3"
var ground_layer = 0
var environment_layer = 1

func _ready():
	Global.scene = "playerHouse"

func _on_inventory_closed():
	get_tree().paused = false

func _on_inventory_opened():
	get_tree().paused = true

func _input(_event):
	if Input.is_action_just_pressed("attack") and Global.tool == 2 and !player.attack_ip and !player.usingTools_ip:
		var player_pos: Vector2 = player.position
		var tile_player_pos: Vector2i = tile_map.local_to_map(player_pos)
		
		var mouse_pos: Vector2 = get_global_mouse_position()
		var tile_mouse_pos: Vector2i = tile_map.local_to_map(mouse_pos) - Vector2i(1, 2)
		
		var dig_zone = get_3x3_zone(tile_player_pos)
		
		if tile_mouse_pos in dig_zone:
			var tile_data: TileData = tile_map.get_cell_tile_data(ground_layer, tile_mouse_pos)
			
			if tile_data:
				var can_dig = tile_data.get_custom_data(can_dig_custom_data)
				if can_dig:
					rotate_player_to(tile_mouse_pos)
					var source_id: int = 2
					var atlas_coord: Vector2i = Vector2i(12, 0)
					tile_map.set_cell(ground_layer, tile_mouse_pos, source_id, atlas_coord)

	elif Input.is_action_just_pressed("attack") and hot_bar.item.name == "Carrot Seeds":
		var mouse_pos : Vector2 = get_global_mouse_position()
		var tile_mouse_pos : Vector2i = tile_map.local_to_map(mouse_pos) - Vector2i(1, 2)
		var source_id : int = 2
		var atlas_coord : Vector2i = Vector2i(13, 0)
		
		if retrieving_custom_data(tile_mouse_pos, can_plant_seed_custom_data, ground_layer):
			var level = 0
			var final_seed_level = 3
			handle_seed(tile_mouse_pos, level, atlas_coord, final_seed_level)
			handle_seed(tile_mouse_pos, level, atlas_coord, final_seed_level)

	elif Input.is_action_just_pressed("attack") and hot_bar.item.name == "Fertilizer":
		var mouse_pos : Vector2 = get_global_mouse_position()
		var tile_mouse_pos : Vector2i = tile_map.local_to_map(mouse_pos) - Vector2i(1, 2)
		var source_id : int = 2
		var atlas_coord : Vector2i = Vector2i.ZERO
		
		var tile_data : TileData = tile_map.get_cell_tile_data(ground_layer, tile_mouse_pos)
		if tile_data:
			if retrieving_custom_data(tile_mouse_pos, can_be_fertilizered_custom_data1, ground_layer):
				atlas_coord = Vector2i(0, 15)
				tile_map.set_cell(1, tile_mouse_pos, source_id, atlas_coord)
			else:
				if retrieving_custom_data(tile_mouse_pos, can_be_fertilizered_custom_data2, ground_layer):
					atlas_coord = Vector2i(1, 15)
					tile_map.set_cell(1, tile_mouse_pos, source_id, atlas_coord)
				else:
					if retrieving_custom_data(tile_mouse_pos, can_be_fertilizered_custom_data3, ground_layer):
						atlas_coord = Vector2i(2, 15)
						tile_map.set_cell(1, tile_mouse_pos, source_id, atlas_coord)

func retrieving_custom_data(tile_mouse_pos, custom_data_layer, layer):
	var tile_data : TileData = tile_map.get_cell_tile_data(layer, tile_mouse_pos)
	if tile_data:
		return tile_data.get_custom_data(custom_data_layer)
	else:
		return false


func get_3x3_zone(player_pos: Vector2i) -> Array:
	var dig_zone = []
	for x in range(-1, 2):
		for y in range(-1, 2):
			dig_zone.append(player_pos + Vector2i(x, y))
	return dig_zone

func rotate_player_to(tile_pos: Vector2i) -> void:
	var player_pos = tile_map.local_to_map(player.position)
	var direction = (Vector2(tile_pos) - Vector2(player_pos)).normalized()

	if abs(direction.x) > abs(direction.y):
		if direction.x > 0:
			player.direction = "Right"
		else:
			player.direction = "Left"
	else:
		if direction.y > 0:
			player.direction = "Down"
		else:
			player.direction = "Up"

func handle_seed(tile_map_pos, level, atlas_coord, final_seed_level):
	var source_id = 2
	tile_map.set_cell(environment_layer - 1, tile_map_pos, source_id, atlas_coord)
	if level == 1:
		tile_map.set_cell(environment_layer + 1, tile_map_pos, source_id, Vector2i(15, 2))
	if level == 2:
		tile_map.set_cell(environment_layer + 1, tile_map_pos, source_id, Vector2i(17, 1))
	if level == 3:
		tile_map.set_cell(environment_layer + 1, tile_map_pos, source_id, Vector2i(19, 1))
	
	await get_tree().create_timer(5.0).timeout
	
	if level == final_seed_level:
		return
	else:
		var new_atlas : Vector2i = Vector2i(atlas_coord.x + 2, atlas_coord.y)
		handle_seed(tile_map_pos, level + 1, new_atlas, final_seed_level)
