extends Node

var tilemap_data = {}

func save_tilemap(tilemap: TileMap):
	tilemap_data.clear()
	for layer in range(5):
		tilemap_data[layer] = {}
		for position in tilemap.get_used_cells(layer):
			var tile_data = {
				"source_id": tilemap.get_cell_source_id(layer, position),
				"atlas_coords": tilemap.get_cell_atlas_coords(layer, position),
				"alternative_tile": tilemap.get_cell_alternative_tile(layer, position)
			}
			tilemap_data[layer][position] = tile_data
	Global.tilemap = tilemap_data

func load_tilemap(tilemap: TileMap):
	clear_tilemap(tilemap)
	for layer in range(5):
		if layer in tilemap_data:
			for position in tilemap_data[layer].keys():
				var tile_data = tilemap_data[layer][position]
				tilemap.set_cell(
					layer, position, tile_data["source_id"],
					tile_data["atlas_coords"], tile_data["alternative_tile"]
				)

func clear_tilemap(tilemap: TileMap):
	for layer in range(5):
		tilemap.clear_layer(layer)
