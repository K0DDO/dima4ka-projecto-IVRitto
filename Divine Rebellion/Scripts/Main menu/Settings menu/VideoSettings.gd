extends Control

@onready var resolution = $Resolution
@onready var fullScreenButton = $CheckBox1
@onready var display_fps = $CheckBox
@onready var v_sync = $CheckBox2
@onready var max_fps_slider = $maxFPSSlider
@onready var max_fps = $maxFPSSlider/maxFPS
@onready var brightness_slider = $brightnessSlider
@onready var brightness = $brightnessSlider/brightness

func _ready():
	max_fps.text = str(SaveSettingsData.maxFPS)
	max_fps_slider.value = SaveSettingsData.maxFPS
	brightness.text = str(SaveSettingsData.brightness)
	brightness_slider.value = SaveSettingsData.brightness
	fullScreenButton.button_pressed = SaveSettingsData.full_screen
	display_fps.button_pressed = SaveSettingsData.show_fps
	v_sync.button_pressed = SaveSettingsData.vsync

func add_items():
	resolution.add_item("1920x1080")
	resolution.add_item("1024×768")
	resolution.add_item("1280x720")
	resolution.add_item("1600x900")

func _on_resolution_item_selected(index):
	var current_selected = index
	
	if current_selected == 0:
		DisplayServer.window_set_size(Vector2i(1920, 1080))
	elif current_selected == 1:
		DisplayServer.window_set_size(Vector2i(1600, 900))
	elif current_selected == 2:
		DisplayServer.window_set_size(Vector2i(1280, 720))
	elif current_selected == 3:
		DisplayServer.window_set_size(Vector2i(854, 480))

func _on_check_box_pressed():
	SaveSettingsData.show_fps = !SaveSettingsData.show_fps

func _on_check_box_2_pressed():
	SaveSettingsData.vsync = !SaveSettingsData.vsync
	if SaveSettingsData.vsync:
		DisplayServer.window_set_vsync_mode(DisplayServer.VSYNC_ENABLED)
	else:
		DisplayServer.window_set_vsync_mode(DisplayServer.VSYNC_DISABLED)

func _on_check_box_1_pressed():
	SaveSettingsData.full_screen = !SaveSettingsData.full_screen
	if SaveSettingsData.full_screen:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
	else:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
		DisplayServer.window_set_size(Vector2i(1920, 1080))

func _on_max_fps_slider_value_changed(value):
	SaveSettingsData.maxFPS = value
	max_fps.text = str(SaveSettingsData.maxFPS)
	Engine.max_fps = SaveSettingsData.maxFPS

func _on_brightness_slider_value_changed(value):
	Brightness.environment.adjustment_brightness = value
	SaveSettingsData.brightness = value
	brightness.text = str(SaveSettingsData.brightness)

func _on_button_pressed():
	get_tree().paused = false
	Global.save_game()
	get_tree().change_scene_to_file("res://Scenes/main_menu.tscn")
