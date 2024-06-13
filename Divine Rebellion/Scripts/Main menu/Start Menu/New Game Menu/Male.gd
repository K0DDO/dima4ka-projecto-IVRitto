extends Sprite2D

@onready var animation = $Animation

func _ready():
	animation.play("idle")

func _on_male_pressed():
	animation.play("pressed")
	Global.gender = 0
	
func _process(_delta):
	if Global.gender != 0:
		animation.play("idle")
