extends Sprite2D

@onready var animations = $BottomButtonAnimation
@onready var bottom = $Bottom

func _ready():
	animations.play("idle")

func _physics_process(_delta):
	if Global.tab != "bottom":
		bottom.set_visible(false)
		animations.play("idle")

func _on_bottom_button_pressed():
	animations.play("pressed")
	Global.tab = "bottom"
	bottom.set_visible(true)



	
