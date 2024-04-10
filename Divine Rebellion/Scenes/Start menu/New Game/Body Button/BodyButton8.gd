extends Sprite2D

@onready var animations = $Button8Animation

func _ready():
	animations.play("idle")

func _physics_process(_delta):
	if Global.bodybutton != "8":
		animations.play("idle")

func _on_button_8_pressed():
	animations.play("pressed")
	Global.bodybutton = "8"
