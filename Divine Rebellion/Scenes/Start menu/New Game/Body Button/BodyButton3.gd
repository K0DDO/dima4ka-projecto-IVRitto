extends Sprite2D

@onready var animations = $Button3Animation

func _ready():
	animations.play("idle")

func _physics_process(_delta):
	if Global.bodybutton != "3":
		animations.play("idle")

func _on_button_3_pressed():
	animations.play("pressed")
	Global.bodybutton = "3"
