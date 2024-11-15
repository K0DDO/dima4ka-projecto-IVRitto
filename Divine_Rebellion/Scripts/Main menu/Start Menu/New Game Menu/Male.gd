extends Sprite2D

@onready var animation = $Animation

func _ready():
	animation.play("idle")

func _on_male_pressed():
	animation.play("pressed")
	Global.gender = 0
	position.y += 1
	await get_tree().create_timer(0.1).timeout
	position.y -= 1
	
func _process(_delta):
	if Global.gender != 0:
		animation.play("idle")
	else:
		animation.play("pressed")
