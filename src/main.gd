extends Node

@export var mob_scene: PackedScene
## Scene path of the level that follows this one. Empty for now; when set,
## on_level_completed() should load it instead of (or after) the end screen.
@export var next_level_path: String = ""
const START_MENU_PATH := "res://scenes/start_menu.tscn"
var score

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var level_resoure = ResourceLoader.load("res://levels/intro.tscn")
	var level = level_resoure.instantiate()
	add_child(level)
	move_child(level, 0)
	Dialogic.timeline_ended.connect(_on_dialogic_timeline_ended)
	# The game is launched from the start menu, so no separate "Start" step.
	new_game()


func on_level_completed() -> void:
	$Player.set_physics_process(false)
	if next_level_path != "":
		pass
	# For now: show the congratulations screen on the HUD.
	$HUD.show_level_complete()



func _on_area_event_area_entered(dialog_name) -> void:
	print("Start of dialog")
	# check if a dialog is already running
	if Dialogic.current_timeline != null:
		return

	$Player.freeze_player()
	Dialogic.start(dialog_name)

	get_viewport().set_input_as_handled()
	print("End of dialog")


func _on_dialogic_timeline_ended() -> void:
	$Player.unfreeze_player()


func _on_continue_requested() -> void:
	# If a next level exists, this is where it would be loaded instead.
	if next_level_path != "":
		# TODO(next level): swap the current level for `next_level_path` here.
		pass
	$Player.set_physics_process(true)


func _on_menu_requested() -> void:
	get_tree().change_scene_to_file(START_MENU_PATH)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	return


func game_over() -> void:
	$ScoreTimer.stop()
	$MobTimer.stop()
	$HUD.show_game_over()

func new_game() -> void:
	score = 0
	$Player.start($StartPosition.position)
	#$StartTimer.start() # Replace with function body.
	$HUD.update_score(score)
	# $HUD.show_message("Get Ready")
	get_tree().call_group("mobs", "queue_free")

func _on_score_timer_timeout() -> void:
	score += 1
	$HUD.update_score(score)


func _on_start_timer_timeout() -> void:
	$MobTimer.start()
	$ScoreTimer.start()
