extends Node

var config
var path_to_save_file := "user://game.cfg"
var section_name := "game"

# сцена
var scene = ""

# перемещение облаков
var coords : Vector2 = Vector2(213, 0)

# выбор вкладки меню
var tab = "body"

# выбор вкладки в инвентаре
var tabinv = "combat"

# имя игрока
var playername = ""

# выбор цвета тела
var bodybutton = 0

# выбор цвета глаз
var eyescolor : Color = Color(0.369, 0.357, 0.357, 1.0)

# выбор типа волос
var hairbutton = 0

# выбор цвета волос
var haircolor : Color = Color(0.349, 0.196, 0.141, 1.0)

# выбор цвета аксессуара
var acccolor : Color = Color(1.0, 0.49, 0.984, 1.0)

# выбор типа куртки
var topbutton = 0

# выбор типа штанов
var bottombutton = 0

# выбор типа ботов
var bootsbutton = 0

# какой стороной повёрнут персонаж (от 0 до 3)
var num = 0

# гендер (0 - "Male", 1 - "Female")
var gender = 0

# улучшение (усилние / скилл, 0 - "Friendship", 1 - "Combat", 2 - "Fishing", 3 - "Farming", 4 - "Collecting", 5 - "Enhanced aura")
var skill = 0

# общее кол-во денег
var totalwealth = 500

# сколько денег сейчас есть
var currentmoney = 500

# уровень дружбы
var friendship = 0

# уровень борьбы
var combating = 0

# уровень рыбачества
var fishing = 0

# уровень фермерства
var farming = 0

# уровень собирательства
var collecting = 0

# уровень магии
var magic = 0

# минуты
var minute = 0

# часы
var hour = 0

# день
var day = 0

# сезон
var season = 0

# год
var year = 0

# экипировано ли оружие и какое
var weapon_equip: bool = false
var weapon: int = 0

# экипирован инструмент и какой
var tool_equip: bool = false
var tool: int = 0

# количество запусков игры
var starts_n = 0

# количество запусков игры
var saves_n = 0

enum EntryPoint {
	DOOR,
	STAIRS_FIRST_FLOOR,
	STAIRS_BASEMENT
}

var entry_point: int = EntryPoint.DOOR



func _ready():
	print("Global автоматически загружен!")
	load_game()
	starts_n += 1

func save_game():
	saves_n += 1
	config.set_value(section_name, "scene", scene)
	config.set_value(section_name, "tab", tab)
	config.set_value(section_name, "tabinv", tabinv)
	config.set_value(section_name, "player_name", playername)
	config.set_value(section_name, "bodybutton", bodybutton)
	config.set_value(section_name, "eyescolor", eyescolor)
	config.set_value(section_name, "hairbutton", hairbutton)
	config.set_value(section_name, "haircolor", haircolor)
	config.set_value(section_name, "acccolor", acccolor)
	config.set_value(section_name, "topbutton", topbutton)
	config.set_value(section_name, "bottombutton", bottombutton)
	config.set_value(section_name, "bootsbutton", bootsbutton)
	config.set_value(section_name, "num", num)
	config.set_value(section_name, "gender", gender)
	config.set_value(section_name, "skill", skill)
	config.set_value(section_name, "totalwealth", totalwealth)
	config.set_value(section_name, "currentmoney", currentmoney)
	config.set_value(section_name, "friendship", friendship)
	config.set_value(section_name, "combating", combating)
	config.set_value(section_name, "fishing", fishing)
	config.set_value(section_name, "farming", farming)
	config.set_value(section_name, "collecting", collecting)
	config.set_value(section_name, "magic", magic)
	config.set_value(section_name, "minute", minute)
	config.set_value(section_name, "hour", hour)
	config.set_value(section_name, "day", day)
	config.set_value(section_name, "season", season)
	config.set_value(section_name, "year", year)
	config.set_value(section_name, "weapon_equip", weapon_equip)
	config.set_value(section_name, "weapon", weapon)
	config.set_value(section_name, "tool_equip", tool_equip)
	config.set_value(section_name, "tool", tool)
	config.set_value(section_name, "starts_n", starts_n)
	config.set_value(section_name, "saves_n", saves_n)
	config.save(path_to_save_file)
	print("Game was saved")
	
func load_game():
	config = ConfigFile.new()
	config.load(path_to_save_file)
	scene = config.get_value(section_name, "scene", "")
	tab = config.get_value(section_name, "tab", "body")
	tabinv = config.get_value(section_name, "tabinv", "combat")
	playername = config.get_value(section_name, "player_name", "Игрок")
	bodybutton = config.get_value(section_name, "bodybutton", 0)
	eyescolor = config.get_value(section_name, "eyescolor", Color(0.369, 0.357, 0.357, 1.0))
	hairbutton = config.get_value(section_name, "hairbutton", 0)
	haircolor = config.get_value(section_name, "haircolor", Color(0.349, 0.196, 0.141, 1.0))
	acccolor = config.get_value(section_name, "acccolor", Color(1.0, 0.49, 0.984, 1.0))
	topbutton = config.get_value(section_name, "topbutton", 0)
	bottombutton = config.get_value(section_name, "bottombutton", 0)
	bootsbutton = config.get_value(section_name, "bootsbutton", 0)
	num = config.get_value(section_name, "num", 0)
	gender = config.get_value(section_name, "gender", 0)
	skill = config.get_value(section_name, "skill", 0)
	totalwealth = config.get_value(section_name, "totalwealth", 500)
	currentmoney = config.get_value(section_name, "currentmoney", 500)
	friendship = config.get_value(section_name, "friendship", 0)
	combating = config.get_value(section_name, "combating", 0)
	fishing = config.get_value(section_name, "fishing", 0)
	farming = config.get_value(section_name, "farming", 0)
	collecting = config.get_value(section_name, "collecting", 0)
	magic = config.get_value(section_name, "magic", 0)
	minute = config.get_value(section_name, "minute", 0)
	hour = config.get_value(section_name, "hour", 0)
	day = config.get_value(section_name, "day", 0)
	season = config.get_value(section_name, "season", 0)
	year = config.get_value(section_name, "year", 1)
	weapon_equip = config.get_value(section_name, "weapon_equip", false)
	weapon = config.get_value(section_name, "weapon", 0)
	tool_equip = config.get_value(section_name, "tool_equip", false)
	tool = config.get_value(section_name, "tool", 0)
	starts_n = config.get_value(section_name, "starts_n", 0)
	saves_n = config.get_value(section_name, "saves_n", 0)
	print("Game was loaded")


