extends Sprite2D

@onready var animations = $Button7Animation

func _ready():
	animations.play("idle")

func _physics_process(_delta):
	if Global.bodybutton != 7:
		animations.play("idle")

func _on_button_7_pressed():
	animations.play("pressed")
	Global.bodybutton = 7
