extends Node2D

var url = "http://127.0.0.1:8000/"

@onready var http_request = $Button/HTTPRequest

func _ready():
	http_request.request_completed.connect(_on_request_completed)
	send_request()
	
func send_request():
	var headers = ["Content-Type: application/json"]
	http_request.request(url, headers, HTTPClient.METHOD_GET)

func _on_request_completed(_results, _response_code, _headers, body):
	var json = JSON.parse_string(body.get_string_from_utf8())
	
	print(json)
