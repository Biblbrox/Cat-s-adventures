extends Node

@export var mob_scene: PackedScene
const START_MENU_PATH := "res://scenes/start_menu.tscn"

var score
var current_level_path = "res://levels/intro/intro.tscn"

func _get_next_level(current_level_path: String) -> String:
	var current_level = current_level_path.get_file()
	if current_level == "intro.tscn":
		return "res://levels/level1/level1.tscn"

	var regex = RegEx.new()
	regex.compile("\\d+")
	var result = regex.search(current_level)
	if result:
		var lvl_idx = result.get_string().to_int()
		print(lvl_idx)
		return "res://levels/level%d/level%d.tscn"

	printerr("Unable to find next level path")
	return ""



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var level_resoure = ResourceLoader.load("res://levels/intro/intro.tscn")
	var level = level_resoure.instantiate()
	add_child(level)
	move_child(level, 0)
	Dialogic.timeline_ended.connect(_on_dialogic_timeline_ended)
	# The game is launched from the start menu, so no separate "Start" step.
	new_game()


func _load_level(level_path: String) -> void:
	print("Loading new level %s" % level_path)
	var level_resoure = ResourceLoader.load(level_path)
	var level = level_resoure.instantiate()
	remove_child(get_child(0))
	add_child(level)
	move_child(level, 0)
	Dialogic.timeline_ended.connect(_on_dialogic_timeline_ended)
	new_game()

func on_level_completed() -> void:
	$Player.set_physics_process(false)

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
	var next_level_path = _get_next_level(current_level_path)
	_load_level(next_level_path)
	current_level_path = next_level_path

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
	$HUD.update_score(score)
	get_tree().call_group("mobs", "queue_free")

func _on_score_timer_timeout() -> void:
	score += 1
	$HUD.update_score(score)


func _on_start_timer_timeout() -> void:
	$MobTimer.start()
	$ScoreTimer.start()
