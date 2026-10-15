extends Node

var player: Player

func _on_dialogic_timeline_ended() -> void:
	player.unfreeze()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print("Spawning mobs")
	player = Session.spawn_character(&"cat", self, $PlayerStartPosition.global_position, true)
	Session.spawn_character(&"dog", self, $DogStartPosition.global_position)
	Dialogic.timeline_ended.connect(_on_dialogic_timeline_ended)

func _on_event_area_event_area_entered(dialog_name) -> void:
	print("_on_event_area_event_area_entered")
	Events.dialog_requested.emit(dialog_name)
	player.freeze()

func _on_final_marker_reached() -> void:
	print("_on_final_marker_reached")
	Events.level_completed.emit()
	player.set_physics_process(false)
