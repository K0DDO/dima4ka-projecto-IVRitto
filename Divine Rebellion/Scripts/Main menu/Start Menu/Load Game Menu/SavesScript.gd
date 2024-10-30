extends Button

@onready var animation = $Animation
@onready var body = $LgButton/Character/Body
@onready var bottom = $LgButton/Character/Bottom
@onready var top = $LgButton/Character/Top
@onready var boots = $LgButton/Character/Boots
@onready var hair = $LgButton/Character/Hair
@onready var eyes = $LgButton/Character/Eyes
@onready var nome = $LgButton/Character/Name
@onready var total_wealth = $LgButton/Character/TotalWealth
@onready var date = $LgButton/Character/Date
@onready var days_spent = $LgButton/Character/DaysSpent

func _ready():
	animation.play("idle")

func _on_pressed():
	animation.play("pressed")

func set_vars(save_data: Dictionary):
	nome.text = save_data["playername"]
	body.set_frame_coords(Vector2i(0, save_data["bodybutton"]))
	bottom.set_frame_coords(Vector2i(0, save_data["bottombutton"]))
	top.set_frame_coords(Vector2i(0, save_data["topbutton"]))
	boots.set_frame_coords(Vector2i(0, save_data["bootsbutton"]))
	hair.set_frame_coords(Vector2i(0, save_data["hairbutton"]))
	eyes.set_frame_coords(Vector2i(0, 0))

	# Клонируем материал для глаз и устанавливаем уникальный цвет
	var eyes_material = eyes.material.duplicate()
	eyes_material.set("shader_parameter/new_color", parse_color_string(save_data["eyescolor"]))
	eyes.material = eyes_material

	# Клонируем материал для волос и устанавливаем уникальные цвета
	var hair_material = hair.material.duplicate()
	hair_material.set("shader_parameter/new_color1", parse_color_string(save_data["haircolor"]))
	hair_material.set("shader_parameter/new_color2", parse_color_string(save_data["acccolor"]))
	hair.material = hair_material

	total_wealth.text = str(save_data["totalwealth"])
	
	var textic = ""
	var day = save_data["day"]
	if day < 10:
		textic += "0" + str(day) + "."
	else:
		textic += str(day) + "."
	
	var season = save_data["season"]
	if season < 10:
		textic += "0" + str(season) + "."
	else:
		textic += str(season) + "."
	
	var year = save_data["year"]
	if year < 10:
		textic += "0" + str(year)
	else:
		textic += str(year)

	date.text = textic
	days_spent.text = str((save_data["year"] - 1) * 28 * 4 + (save_data["season"] - 1) * 28 + save_data["day"] - 1)

func parse_color_string(color_string: String) -> Color:
	color_string = color_string.strip_edges().replace("(", "").replace(")", "")
	var components = color_string.split(",")

	if components.size() != 4:
		return Color(1, 1, 1, 1)  # Возвращаем белый в случае ошибки

	var r = clamp(components[0].strip_edges().to_float(), 0.0, 1.0)
	var g = clamp(components[1].strip_edges().to_float(), 0.0, 1.0)
	var b = clamp(components[2].strip_edges().to_float(), 0.0, 1.0)
	var a = clamp(components[3].strip_edges().to_float(), 0.0, 1.0)

	return Color(r, g, b, a)

