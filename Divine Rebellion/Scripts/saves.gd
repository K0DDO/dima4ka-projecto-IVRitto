extends Node

func save_game(save_name: String):
	var save_data = {}
	save_data["tilemap"] = Global.tilemap
	save_data["playername"] = Global.playername
	save_data["inventory"] = Global.inventory
	save_data["bodybutton"] = Global.bodybutton
	save_data["eyescolor"] = Global.eyescolor
	save_data["hairbutton"] = Global.hairbutton
	save_data["haircolor"] = Global.haircolor
	save_data["acccolor"] = Global.acccolor
	save_data["topbutton"] = Global.topbutton
	save_data["bottombutton"] = Global.bottombutton
	save_data["bootsbutton"] = Global.bootsbutton
	save_data["gender"] = Global.gender
	save_data["skill"] = Global.skill
	save_data["totalwealth"] = Global.totalwealth
	save_data["currentmoney"] = Global.currentmoney
	save_data["friendship"] = Global.friendship
	save_data["combating"] = Global.combating
	save_data["fishing"] = Global.fishing
	save_data["farming"] = Global.farming
	save_data["collecting"] = Global.collecting
	save_data["magic"] = Global.magic
	save_data["second"] = Global.second
	save_data["minute"] = Global.minute
	save_data["hour"] = Global.hour
	save_data["day"] = Global.day
	save_data["season"] = Global.season
	save_data["year"] = Global.year
	save_data["currentWaterLvl"] = Global.currentWaterLvl
	save_data["currentHealth"] = Global.currentHealth
	save_data["currentMana"] = Global.currentMana
	save_data["incafe"] = Global.incafe
	save_data["got_gold_key"] = Global.got_gold_key
	var save_path = "user://saves/" + save_name + ".json"
		
	var dir = DirAccess.open("user://saves/")
	if dir == null:
		DirAccess.make_dir_absolute("user://saves/")
	
	var file = FileAccess.open(save_path, FileAccess.ModeFlags.WRITE)
	if file:
		file.store_string(JSON.stringify(save_data))
		file.close()

func save_inventory(inventory):
	var inventory_data = []
	
	for slot in inventory.slots:
		if slot.item:
			var item_name = slot.item.resource_path.get_file().get_basename()
			var item_data = {
				"name": item_name,
				"amount": slot.amount,
				"slot_index": inventory.slots.find(slot)
			}
			inventory_data.append(item_data)
	
	Global.inventory = inventory_data

func load_inventory(inventory):
	if not Global.inventory:
		return
	
	for slot in inventory.slots:
		slot.item = null
		slot.amount = 0
	
	for item_data in Global.inventory:
		var item_name = item_data["name"]
		var amount = item_data["amount"]
		var slot_index = item_data["slot_index"]
		if item_name != "":
			var item = load("res://Scripts/Game/Inventory/items/" + item_name + ".tres")
		
			if item:
				var inventory_slot = inventory.slots[slot_index]
				inventory_slot.item = item
				inventory_slot.amount = amount

func load_game(save_name: String) -> bool:
	var save_path = "user://saves/" + save_name + ".json"
	var file = FileAccess.open(save_path, FileAccess.ModeFlags.READ)
	
	if !file:
		print("Save file not found.")
		return false
	
	var save_data = JSON.parse_string(file.get_as_text())
	file.close()

	if typeof(save_data) != TYPE_DICTIONARY:
		print("Invalid save file format.")
		return false

	Global.playername = save_data.get("playername", Global.playername)
	Global.currentHealth = save_data.get("player_health", Global.currentHealth)
	Global.inventory = save_data.get("inventory", Global.inventory)
	Global.bodybutton = save_data.get("bodybutton", Global.bodybutton)
	Global.eyescolor = parse_color_string(save_data["eyescolor"])
	Global.hairbutton = save_data.get("hairbutton", Global.hairbutton)
	Global.haircolor = parse_color_string(save_data["haircolor"])
	Global.acccolor = parse_color_string(save_data["acccolor"])
	Global.topbutton = save_data.get("topbutton", Global.topbutton)
	Global.bottombutton = save_data.get("bottombutton", Global.bottombutton)
	Global.bootsbutton = save_data.get("bootsbutton", Global.bootsbutton)
	Global.gender = save_data.get("gender", Global.gender)
	Global.skill = save_data.get("skill", Global.skill)
	Global.totalwealth = save_data.get("totalwealth", Global.totalwealth)
	Global.currentmoney = save_data.get("currentmoney", Global.currentmoney)
	Global.friendship = save_data.get("friendship", Global.friendship)
	Global.combating = save_data.get("combating", Global.combating)
	Global.fishing = save_data.get("fishing", Global.fishing)
	Global.farming = save_data.get("farming", Global.farming)
	Global.collecting = save_data.get("collecting", Global.collecting)
	Global.magic = save_data.get("magic", Global.magic)
	Global.second = save_data.get("second", Global.second)
	Global.minute = save_data.get("minute", Global.minute)
	Global.hour = save_data.get("hour", Global.hour)
	Global.day = save_data.get("day", Global.day)
	Global.season = save_data.get("season", Global.season)
	Global.year = save_data.get("year", Global.year)
	Global.currentWaterLvl = save_data.get("currentWaterLvl", Global.currentWaterLvl)
	Global.currentMana = save_data.get("currentMana", Global.currentMana)
	Global.incafe = save_data.get("incafe", Global.incafe)
	Global.got_gold_key = save_data.get("got_gold_key", Global.got_gold_key)

	return true
	
func parse_color_string(color_string: String) -> Color:
	color_string = color_string.strip_edges().replace("(", "").replace(")", "")
	var components = color_string.split(",")

	if components.size() != 4:
		return Color(1, 1, 1, 1)

	var r = clamp(components[0].strip_edges().to_float(), 0.0, 1.0)
	var g = clamp(components[1].strip_edges().to_float(), 0.0, 1.0)
	var b = clamp(components[2].strip_edges().to_float(), 0.0, 1.0)
	var a = clamp(components[3].strip_edges().to_float(), 0.0, 1.0)

	return Color(r, g, b, a)
