extends Node2D

signal waterChanged

@onready var inventory = $TileMap/Player/CanvasLayer/inventory
@onready var tile_map = $TileMap
@onready var player = $TileMap/Player
@onready var hot_bar = $TileMap/Player/CanvasLayer/HotBar

var can_dig_custom_data = "can_dig"
var can_plant_seed_custom_data = "can_plant_seed"
var can_be_watered_custom_data = "can_be_watered"
var crop_level = "crop_level"
var can_be_fertilizered_custom_data1 = "can_be_fertilizered1"
var can_be_fertilizered_custom_data2 = "can_be_fertilizered2"
var can_be_fertilizered_custom_data3 = "can_be_fertilizered3"
var contain_water_custom_data = "contain_water"
var ground_layer = 0
var environment_layer = 2
var final_seed_level = 3

var carrot_scene = preload("res://Scenes/Game/Collectables/Carrot.tscn")

func _ready():
	if !TileMapSave.tilemap_data:
		TileMapSave.save_tilemap(tile_map)
		print("сохранил")
	else:
		TileMapSave.load_tilemap(tile_map)
		print("загрузил")
	Global.scene = "playerHouse"
	match Global.entry_point:
		Global.EntryPoint.fCtF:
			player.position = Vector2(972, 484)
		Global.EntryPoint.fFtC:
			player.position = Vector2(200, 278)
		Global.EntryPoint.fFtCave:
			player.position = Vector2(200, 278)
		Global.EntryPoint.fCavetF:
			player.position = Vector2(361, 118)


func _input(_event):
	if Input.is_action_just_pressed("attack") and Global.tool == 3 and Global.tool_equip == true and !player.attack_ip and !player.usingTools_ip and Global.currentMana > 0:
			var player_pos: Vector2 = player.position
			var tile_player_pos: Vector2i = tile_map.local_to_map(player_pos)
			var mouse_pos: Vector2 = get_global_mouse_position()
			var tile_mouse_pos: Vector2i = tile_map.local_to_map(mouse_pos)
			var atlas_coord = Vector2i(14, 0)
			var dig_zone = get_3x3_zone(tile_player_pos)
			
			if tile_mouse_pos in dig_zone:
				if retrieving_custom_data(tile_mouse_pos, can_be_watered_custom_data, ground_layer) and Global.currentWaterLvl > 0:
					var level = retrieving_custom_data(tile_mouse_pos, crop_level, ground_layer)
					rotate_player_to(tile_mouse_pos)
					Global.currentWaterLvl -= 1
					water_tile(tile_mouse_pos, level, final_seed_level, atlas_coord)
				if retrieving_custom_data(tile_mouse_pos, contain_water_custom_data, ground_layer) and Global.currentWaterLvl >= 0:   
					rotate_player_to(tile_mouse_pos)
					Global.currentWaterLvl = Global.maxWaterLvl
				waterChanged.emit()
	
	elif Input.is_action_just_pressed("attack") and Global.tool == 2 and Global.tool_equip == true and !player.attack_ip and !player.usingTools_ip and Global.currentMana > 0:
		var player_pos: Vector2 = player.position
		var tile_player_pos: Vector2i = tile_map.local_to_map(player_pos)
		
		var mouse_pos: Vector2 = get_global_mouse_position()
		var tile_mouse_pos: Vector2i = tile_map.local_to_map(mouse_pos)
		var dig_zone = get_3x3_zone(tile_player_pos)
		
		if tile_mouse_pos in dig_zone:
			var tile_data: TileData = tile_map.get_cell_tile_data(ground_layer, tile_mouse_pos)
			if tile_data:
				var can_dig = tile_data.get_custom_data(can_dig_custom_data)
				if can_dig:
					rotate_player_to(tile_mouse_pos)
					dig_ground(tile_mouse_pos)
			tile_data = tile_map.get_cell_tile_data(ground_layer, tile_mouse_pos)
			if tile_data:
				var crop_ready = tile_data.get_custom_data("crop_level") == 3
				if crop_ready:
					rotate_player_to(tile_mouse_pos)
					harvest_crop(tile_mouse_pos)
						
	elif Input.is_action_just_pressed("attack") and hot_bar.item and hot_bar.item.name == "Carrot Seeds":
		var mouse_pos: Vector2 = get_global_mouse_position()
		var tile_mouse_pos: Vector2i = tile_map.local_to_map(mouse_pos)
		var atlas_coord: Vector2i = Vector2i(13, 0)

		if retrieving_custom_data(tile_mouse_pos, can_plant_seed_custom_data, ground_layer):
			var level = 0
			plant_seed(tile_mouse_pos, level, atlas_coord, final_seed_level)
			
			inventory.reduce_item(hot_bar.currently_selected, 1)
			hot_bar.update()

	elif Input.is_action_just_pressed("attack") and hot_bar.item and hot_bar.item.name == "Fertilizer":
		var mouse_pos: Vector2 = get_global_mouse_position()
		var tile_mouse_pos: Vector2i = tile_map.local_to_map(mouse_pos)
		var source_id: int = 2
		var atlas_coord: Vector2i = Vector2i.ZERO

		if retrieving_custom_data(tile_mouse_pos, can_be_fertilizered_custom_data1, ground_layer):
			atlas_coord = Vector2i(0, 15)
			tile_map.set_cell(environment_layer-1, tile_mouse_pos, source_id, atlas_coord)
		elif retrieving_custom_data(tile_mouse_pos, can_be_fertilizered_custom_data2, ground_layer):
			atlas_coord = Vector2i(1, 15)
			tile_map.set_cell(environment_layer-1, tile_mouse_pos, source_id, atlas_coord)
		elif retrieving_custom_data(tile_mouse_pos, can_be_fertilizered_custom_data3, ground_layer):
			atlas_coord = Vector2i(2, 15)
			tile_map.set_cell(environment_layer-1, tile_mouse_pos, source_id, atlas_coord)
		
		inventory.reduce_item(hot_bar.currently_selected, 1)
		hot_bar.update()

func water_tile(tile_mouse_pos: Vector2i, level, _final_seed_level, atlas_coord):
	var tile_data: TileData = tile_map.get_cell_tile_data(ground_layer, tile_mouse_pos)
	var source_id = 2
	if typeof(level) == TYPE_INT:
		if tile_data:
			if level == 0:
				atlas_coord = Vector2i(14, 0)
			if level == 1:
				atlas_coord = Vector2i(16, 0)
			if level == 2:
				atlas_coord = Vector2i(18, 0)
			tile_map.set_cell(ground_layer, tile_mouse_pos, source_id, atlas_coord)
	
		await get_tree().create_timer(5.0).timeout
		
		if level < final_seed_level:
			level += 1
			atlas_coord = atlas_coord + Vector2i(1, 0)
			tile_map.set_cell(ground_layer, tile_mouse_pos, source_id, atlas_coord)
			if level < 2:
				tile_map.set_cell(environment_layer, tile_mouse_pos, source_id, atlas_coord + Vector2i(0, 2))
			else:
				tile_map.set_cell(environment_layer, tile_mouse_pos, source_id, atlas_coord + Vector2i(0, 1))

func dig_ground(tile_mouse_pos: Vector2i):
	var source_id: int = 2
	var atlas_coord: Vector2i = Vector2i(12, 0)
	tile_map.set_cell(ground_layer, tile_mouse_pos, source_id, atlas_coord)

func harvest_crop(tile_mouse_pos: Vector2i):
	var tile_data: TileData = tile_map.get_cell_tile_data(environment_layer, tile_mouse_pos)
	if tile_data:
		crop_level = tile_data.get_custom_data("crop_level")
		if crop_level == 3:
			if retrieving_custom_data(tile_mouse_pos, can_be_fertilizered_custom_data3, environment_layer-1):
				add_carrots_to_inventory(tile_mouse_pos)
			add_carrots_to_inventory(tile_mouse_pos)
			tile_map.set_cell(environment_layer, tile_mouse_pos, -1)
			tile_map.set_cell(environment_layer-1, tile_mouse_pos, -1)
			tile_map.set_cell(ground_layer, tile_mouse_pos, 2, Vector2i(1, 7))

func add_carrots_to_inventory(tile_mouse_pos: Vector2i):
	var carrot_instance = carrot_scene.instantiate()
	carrot_instance.position = tile_map.map_to_local(tile_mouse_pos)
	get_tree().current_scene.add_child(carrot_instance)

func retrieving_custom_data(tile_mouse_pos, custom_data_layer, layer):
	var tile_data : TileData = tile_map.get_cell_tile_data(layer, tile_mouse_pos)
	if tile_data:
		if typeof(custom_data_layer) != TYPE_STRING:
			return false
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

func plant_seed(tile_map_pos, _level, _atlas_coord, _final_seed_level):
	var source_id = 2
	tile_map.set_cell(ground_layer, tile_map_pos, source_id, Vector2i(13, 0))
	
func _on_inventory_closed():
	get_tree().paused = false

func _on_inventory_opened():
	get_tree().paused = true
