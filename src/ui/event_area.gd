extends Area2D

signal event_area_entered(dialog_name)

var hit = false
@export var one_shot = false
@export var dialog_name = ""

func _on_body_entered(body: Node2D) -> void:
	if one_shot and hit:
		return

	if body is Player:
		var player = body as Player
		if !player.controlable:
			return
		print("Player entered event area")
		event_area_entered.emit(dialog_name)
		hit = true
