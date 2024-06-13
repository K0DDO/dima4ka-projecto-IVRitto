extends Sprite2D

@onready var animations = $BodyButtonAnimation
@onready var body = $Body

func _ready():
	animations.play("focused")
	body.set_visible(true)
	
func _physics_process(_delta):
	if Global.tab != "body":
		body.set_visible(false)
		animations.play("idle")

func _on_body_button_pressed():
	animations.play("pressed")
	Global.tab = "body"
	body.set_visible(true)
