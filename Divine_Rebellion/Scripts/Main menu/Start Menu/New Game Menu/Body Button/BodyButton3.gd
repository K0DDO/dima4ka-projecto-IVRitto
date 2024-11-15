extends Sprite2D

@onready var animations = $Button3Animation

func _ready():
	animations.play("idle")

func _physics_process(_delta):
	if Global.bodybutton != 2:
		animations.play("idle")
	else:
		animations.play("focused")

func _on_button_3_pressed():
	Global.bodybutton = 2
	position.y += 1
	await get_tree().create_timer(0.1).timeout
	position.y -= 1
