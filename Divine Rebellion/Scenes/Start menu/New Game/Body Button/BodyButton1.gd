extends Sprite2D

@onready var animations = $Button1Animation

func _ready():
	animations.play("focused")

func _physics_process(_delta):
	if Global.bodybutton != "1":
		animations.play("idle")

func _on_button_pressed():
	animations.play("pressed")
	Global.bodybutton = "1"
