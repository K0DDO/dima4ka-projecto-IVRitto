extends Sprite2D

@onready var animations = $Button1Animation

func _ready():
	animations.play("focused")

func _process(_delta):
	if Global.bodybutton != 0:
		animations.play("idle")
	else:
		animations.play("focused")

func _on_button_pressed():
	Global.bodybutton = 0
	position.y += 1
	await get_tree().create_timer(0.1).timeout
	position.y -= 1
	
	
