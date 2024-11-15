extends Sprite2D

@onready var animations = $TopButtonAnimation
@onready var top = $Top

func _ready():
	animations.play("idle")

func _physics_process(_delta):
	if Global.tab != "top":
		top.set_visible(false)
		animations.play("idle")

func _on_top_button_pressed():
	animations.play("pressed")
	Global.tab = "top"
	top.set_visible(true)
