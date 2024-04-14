extends Sprite2D

@onready var animations = $BootsButtonAnimation
@onready var boots = $Boots

func _ready():
	animations.play("idle")

func _physics_process(_delta):
	if Global.tab != "boots":
		boots.set_visible(false)
		animations.play("idle")

func _on_boots_button_pressed():
	animations.play("pressed")
	Global.tab = "boots"
	boots.set_visible(true)
