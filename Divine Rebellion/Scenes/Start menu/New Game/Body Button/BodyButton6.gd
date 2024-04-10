extends Sprite2D

@onready var animations = $Button6Animation

func _ready():
	animations.play("idle")

func _physics_process(_delta):
	if Global.bodybutton != "6":
		animations.play("idle")

func _on_button_6_pressed():
	animations.play("pressed")
	Global.bodybutton = "6"
