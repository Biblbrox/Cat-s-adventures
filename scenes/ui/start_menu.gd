extends Control

const GAME_SCENE_PATH := "res://scenes/main.tscn"


# Starts a fresh new game with replacement of the current scene
func _on_start_new_game_pressed() -> void:
	var err := get_tree().change_scene_to_file(GAME_SCENE_PATH)
	if err != OK:
		push_error("StartMenu: failed to open game scene %s (error %d)" % [GAME_SCENE_PATH, err])


func _on_continue_pressed() -> void:
	print("[StartMenu] Continue pressed - not implemented yet")


func _on_settings_pressed() -> void:
	print("[StartMenu] Settings pressed - not implemented yet")
