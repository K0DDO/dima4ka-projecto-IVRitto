extends Sprite2D

@onready var animations = $HairColorButtonAnimation
@onready var haircolor = $HairColor
@onready var acc = $"../../Control2"
@onready var hair = $"../../Control"

func _ready():
	animations.play("idle")

func _physics_process(_delta):
	if Global.tab != "haircolor":
		haircolor.set_visible(false)
		acc.set_visible(false)
		hair.set_visible(false)
		animations.play("idle")

func _on_hair_color_button_pressed():
	animations.play("pressed")
	Global.tab = "haircolor"
	haircolor.set_visible(true)
	hair.set_visible(true)
	acc.set_visible(true)
