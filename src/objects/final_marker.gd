extends Area2D
## Emitted once when the player reaches the final marker of the mission
signal marker_reached

var hit := false


func _on_body_entered(body: Node2D) -> void:
	if hit:
		return
	if body is CharacterBody2D and body.name == "Player":
		marker_reached.emit()
		hit = true
