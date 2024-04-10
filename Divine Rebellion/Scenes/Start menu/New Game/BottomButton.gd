extends Sprite2D

@onready var animations = $BottomButtonAnimation

func _ready():
	animations.play("idle")

func _physics_process(_delta):
	if Global.tab != "bottom":
			animations.play("idle")

func _on_bottom_button_pressed():
	animations.play("pressed")
	Global.tab = "bottom"



	
