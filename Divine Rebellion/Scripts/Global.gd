extends Node

# перемещение облаков
var coords : Vector2 = Vector2(213, 0)

# выбор вкладки меню
var tab = "body"

# выбор цвета тела
var bodybutton = 0

# выбор цвета глаз
var eyebutton = 0

# выбор типа волос
var hairbutton = 0

# выбор цвета волос
var haircolor : Color = Color(0.349, 0.196, 0.141, 1.0)

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
