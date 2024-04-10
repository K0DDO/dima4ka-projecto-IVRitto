extends Sprite2D

@onready var animations = $TopButtonAnimation

func _ready():
	animations.play("idle")

func _physics_process(_delta):
	if Global.tab != "top":
			animations.play("idle")

func _on_top_button_pressed():
	animations.play("pressed")
	Global.tab = "top"
