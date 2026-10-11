extends Area2D

signal event_area_entered(dialog_name)

# TODO: check if I really need this
var first_run = true

var hit = false
@export var one_shot = false
@export var dialog_name = ""

func _on_body_entered(body: Node2D) -> void:
	if one_shot and hit:
		return

	if body is CharacterBody2D and body.name == "Player":
		print("body entered")
		event_area_entered.emit(dialog_name)
		hit = true
