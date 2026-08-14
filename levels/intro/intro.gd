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


# func _on_intro_area_event_area_entered() -> void:
# 	
func _on_intro_area_event_area_entered() -> void:
	# check if a dialog is already running
	if Dialogic.current_timeline != null:
		return

	Dialogic.start('intro')
	get_viewport().set_input_as_handled()


func _on_dog_meet_area_event_area_entered() -> void:
	if Dialogic.current_timeline != null:
		return

	Dialogic.start('dog_first_meet')
	get_viewport().set_input_as_handled()
