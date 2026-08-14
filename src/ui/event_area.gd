extends Area2D

signal event_area_entered

var first_run = true
var hit = false

func _on_body_entered(body: Node2D) -> void:
	if body is CharacterBody2D and body.name == "Player":
		print("body entered")
		event_area_entered.emit()
