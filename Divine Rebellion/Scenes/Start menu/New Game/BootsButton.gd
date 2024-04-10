extends Sprite2D

@onready var animations = $BootsButtonAnimation

func _ready():
	animations.play("idle")

func _physics_process(_delta):
	if Global.tab != "boots":
			animations.play("idle")

func _on_boots_button_pressed():
	animations.play("pressed")
	Global.tab = "boots"
