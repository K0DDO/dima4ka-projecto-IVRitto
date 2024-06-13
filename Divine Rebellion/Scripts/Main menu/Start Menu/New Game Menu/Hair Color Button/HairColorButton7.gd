extends Sprite2D

@onready var animations = $Button7Animation

func _ready():
	animations.play("idle")

func _process(_delta):
	pass

func _on_button_7_pressed():
	animations.play("pressed")
	Global.haircolorbutton = 6
