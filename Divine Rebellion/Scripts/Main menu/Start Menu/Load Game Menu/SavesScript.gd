extends Button

@onready var animation = $Animation

func _ready():
	animation.play("idle")

func _on_pressed():
	animation.play("pressed")
	
