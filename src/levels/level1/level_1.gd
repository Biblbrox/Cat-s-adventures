extends Node

func _ready() -> void:
	print("Second level loaded")


# func _on_event_area_event_area_entered(dialog_name) -> void:
# 	var game := get_parent()
# 	if game != null and game.has_method("_on_area_event_area_entered"):
# 		game._on_area_event_area_entered(dialog_name)


func _on_final_marker_reached() -> void:
	var game := get_parent()
	if game != null and game.has_method("on_level_completed"):
		game.on_level_completed()
