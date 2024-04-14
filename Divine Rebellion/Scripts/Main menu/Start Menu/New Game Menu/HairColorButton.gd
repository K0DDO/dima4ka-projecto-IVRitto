extends Sprite2D

@onready var animations = $HairColorButtonAnimation
@onready var haircolor = $HairColor

func _ready():
	animations.play("idle")

func _physics_process(_delta):
	if Global.tab != "haircolor":
		haircolor.set_visible(false)
		animations.play("idle")

func _on_hair_color_button_pressed():
	animations.play("pressed")
	Global.tab = "haircolor"
	haircolor.set_visible(true)
