extends Sprite2D

@onready var animations = $Button2Animation

func _ready():
	animations.play("idle")

func _physics_process(_delta):
	if Global.bodybutton != 1:
		animations.play("idle")
	else:
		animations.play("focused")

func _on_button_2_pressed():
	Global.bodybutton = 1
	position.y += 1
	await get_tree().create_timer(0.1).timeout
	position.y -= 1
