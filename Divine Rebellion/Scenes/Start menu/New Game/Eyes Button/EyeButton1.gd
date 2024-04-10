extends Sprite2D

@onready var animations = $Button1Animation

func _ready():
	animations.play("focused")

func _physics_process(_delta):
	if Global.eyebutton != "1":
		animations.play("idle")

func _on_button_1_pressed():
	animations.play("pressed")
	Global.eyebutton = "1"
