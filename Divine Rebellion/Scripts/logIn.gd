extends Node2D

var url = "http://127.0.0.1:8000/"
@onready var http_request = $HTTPRequest
@onready var login_text = $Login/LoginText
@onready var password_text = $Password/PasswordText
@onready var animation = $ColorRect/Animation

func _on_button_pressed():
	if login_text.text != "":
		login_user()

func _on_http_request_request_completed(_result, response_code, _headers, body):
	var data = JSON.parse_string(body.get_string_from_utf8())
	if response_code == 200:
		animation.play("fade_out")
		Global.username = data.username
		get_tree().change_scene_to_file("res://Scenes/main_menu.tscn")
	else:
		$Message.visible = true
		await get_tree().create_timer(1).timeout
		$Message.visible = false

func login_user():
	http_request.request(url+"signup_or_signin?username="+login_text.text+"&password="+password_text.text, ["Content-Type: application/json"], HTTPClient.METHOD_POST)

func _on_button2_pressed():
	Global.username = ""
	get_tree().change_scene_to_file("res://Scenes/main_menu.tscn")

func _input(_event):
	if Input.is_key_pressed(KEY_ESCAPE):
		get_tree().change_scene_to_file("res://Scenes/main_menu.tscn")
