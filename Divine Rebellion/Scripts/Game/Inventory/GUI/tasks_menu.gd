extends Button

@onready var label_2 = $Label2

func _ready():
	visible = Global.taskv

func _process(delta):
	label_2.text = str(Global.mobdead)+"/5"
