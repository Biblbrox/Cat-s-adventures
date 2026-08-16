extends Area2D

signal event_area_entered

# TODO: check if I really need this
var first_run = true

var hit = false
@export var one_shot = false

func _on_body_entered(body: Node2D) -> void:
	if one_shot and hit:
		return

	if body is CharacterBody2D and body.name == "Player":
		print("body entered")
		event_area_entered.emit()
		hit = true
