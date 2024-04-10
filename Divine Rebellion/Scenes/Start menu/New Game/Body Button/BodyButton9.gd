extends Sprite2D

@onready var animations = $Button9Animation

func _ready():
	animations.play("idle")

func _physics_process(_delta):
	if Global.bodybutton != "9":
		animations.play("idle")

func _on_button_9_pressed():
	animations.play("pressed")
	Global.bodybutton = "9"
