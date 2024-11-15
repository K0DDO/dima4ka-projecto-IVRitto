extends Sprite2D

@onready var animations = $EyesButtonAnimation
@onready var eyes = $Eyes
@onready var eyes_color = $"../../Control3"

func _ready():
	animations.play("idle")

func _physics_process(_delta):
	if Global.tab != "eyes":
		eyes.set_visible(false)
		eyes_color.set_visible(false)
		animations.play("idle")

func _on_eyes_button_pressed():
	animations.play("pressed")
	Global.tab = "eyes"
	eyes.set_visible(true)
	eyes_color.set_visible(true)
