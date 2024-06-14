extends Sprite2D

@onready var animation = $Animation

func _ready():
	animation.play("idle")

func _on_female_pressed():
	animation.play("pressed")
	Global.gender = 1
	position.y += 1
	await get_tree().create_timer(0.1).timeout
	position.y -= 1
	

func _process(_delta):
	if Global.gender != 1:
		animation.play("idle")
