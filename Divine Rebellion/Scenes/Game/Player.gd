extends Node2D

@onready var animations = $Animations

func _ready():
	animations.play("d_idle")

func _input(event):
	if event is InputEventMouseButton:
		animations.play("l_idle")
