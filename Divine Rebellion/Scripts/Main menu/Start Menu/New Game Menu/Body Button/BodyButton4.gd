extends Sprite2D

@onready var animations = $Button4Animation

func _ready():
	animations.play("idle")

func _physics_process(_delta):
	if Global.bodybutton != 4:
		animations.play("idle")

func _on_button_4_pressed():
	animations.play("pressed")
	Global.bodybutton = 4
