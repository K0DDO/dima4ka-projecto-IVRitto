extends Node2D

@onready var combatmini = $Combatmini
@onready var mapmini = $Mapmini
@onready var profilemini = $Profilemini
@onready var bookmini = $Bookmini
@onready var settingsmini = $Settingsmini
@onready var mapmini_2 = $Mapmini2
@onready var profilemini_2 = $Profilemini2
@onready var bookmini_2 = $Bookmini2
@onready var settingsmini_2 = $Settingsmini2
@onready var combat = $"../Combat"
@onready var map = $"../Map"
@onready var profile = $"../Profile"
@onready var book = $"../Book"
@onready var settings = $"../Settings"

func _process(_delta):
	if Global.tabinv == "combat":
		combatmini.frame = 0
		mapmini.frame = 1
		profilemini.frame = 1
		bookmini.frame = 1
		settingsmini.frame = 1
		combat.visible = true
		map.visible = false
		profile.visible = false
		book.visible = false
		settings.visible = false
		combatmini.visible = true
		mapmini.visible = false
		profilemini.visible = false
		bookmini.visible = false
		settingsmini.visible = false
		mapmini_2.visible = true
		profilemini_2.visible = true
		bookmini_2.visible = true
		settingsmini_2.visible = true
	elif Global.tabinv == "map":
		combatmini.frame = 1
		mapmini.frame = 0
		profilemini.frame = 1
		bookmini.frame = 1
		settingsmini.frame = 1
		combat.visible = false
		map.visible = true
		profile.visible = false
		book.visible = false
		settings.visible = false
		mapmini.visible = true
		profilemini.visible = false
		bookmini.visible = false
		settingsmini.visible = false
		mapmini_2.visible = false
		profilemini_2.visible = true
		bookmini_2.visible = true
		settingsmini_2.visible = true
	elif Global.tabinv == "profile":
		combatmini.frame = 1
		mapmini.frame = 1
		profilemini.frame = 0
		bookmini.frame = 1
		settingsmini.frame = 1
		combat.visible = false
		map.visible = false
		profile.visible = true
		book.visible = false
		settings.visible = false
		combatmini.visible = true
		mapmini.visible = true
		profilemini.visible = true
		bookmini.visible = false
		settingsmini.visible = false
		mapmini_2.visible = false
		profilemini_2.visible = false
		bookmini_2.visible = true
		settingsmini_2.visible = true
	elif Global.tabinv == "book":
		combatmini.frame = 1
		mapmini.frame = 1
		profilemini.frame = 1
		bookmini.frame = 0
		settingsmini.frame = 1
		combat.visible = false
		map.visible = false
		profile.visible = false
		book.visible = true
		settings.visible = false
		combatmini.visible = true
		mapmini.visible = true
		profilemini.visible = true
		bookmini.visible = true
		settingsmini.visible = false
		mapmini_2.visible = false
		profilemini_2.visible = false
		bookmini_2.visible = false
		settingsmini_2.visible = true
	elif Global.tabinv == "settings":
		combatmini.frame = 1
		mapmini.frame = 1
		profilemini.frame = 1
		bookmini.frame = 1
		settingsmini.frame = 0
		combat.visible = false
		map.visible = false
		profile.visible = false
		book.visible = false
		settings.visible = true
		combatmini.visible = true
		mapmini.visible = true
		profilemini.visible = true
		bookmini.visible = true
		settingsmini.visible = true
		mapmini_2.visible = false
		profilemini_2.visible = false
		bookmini_2.visible = false
		settingsmini_2.visible = false

func _on_button1_pressed():
	Global.tabinv = "combat"

func _on_button2_pressed():
	Global.tabinv = "map"

func _on_button3_pressed():
	Global.tabinv = "profile"

func _on_button4_pressed():
	Global.tabinv = "book"

func _on_button5_pressed():
	Global.tabinv = "settings"

func _on_button6_pressed():
	Global.tabinv = "map"

func _on_button7_pressed():
	Global.tabinv = "profile"

func _on_button8_pressed():
	Global.tabinv = "book"

func _on_button9_pressed():
	Global.tabinv = "settings"
