extends Node

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print("Test")
	var dog_resource = ResourceLoader.load("res://scenes/players/dog.tscn")
	var dog = dog_resource.instantiate()
	add_child(dog)
	move_child(dog, 0)
	dog.start($DogStartPosition.position)
	# dog.play_animation("idle")


func _on_event_area_event_area_entered(dialog_name) -> void:
	var game := get_parent()
	if game != null and game.has_method("_on_area_event_area_entered"):
		game._on_area_event_area_entered(dialog_name)


func _on_final_marker_reached() -> void:
	var game := get_parent()
	if game != null and game.has_method("on_level_completed"):
		game.on_level_completed()
