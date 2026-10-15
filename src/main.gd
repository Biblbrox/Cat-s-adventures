extends Node

@export var mob_scene: PackedScene
const START_MENU_PATH := "res://src/start_menu.tscn"

var score
var current_level_path = "res://src/levels/intro/intro.tscn"
var current_level: Node

func _get_next_level() -> String:
	var file := current_level_path.get_file()
	if file == "intro.tscn":
		return "res://src/levels/level1/level1.tscn"
	var result := RegEx.create_from_string("\\d+").search(file)
	if result:
		var next_idx := result.get_string().to_int() + 1
		var next_path := "res://src/levels/level%d/level%d.tscn" % [next_idx, next_idx]
		if ResourceLoader.exists(next_path):
			return next_path
	return ""



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Events.dialog_requested.connect(_on_area_event_area_entered)
	Events.level_completed.connect(on_level_completed)
	_load_level(current_level_path)

func _load_level(path: String) -> void:
	print("Loading level %s" % path)
	if current_level != null:
		current_level.queue_free()
	current_level = (load(path) as PackedScene).instantiate()
	add_child(current_level)
	move_child(current_level, 0)
	current_level_path = path
	new_game()

func on_level_completed() -> void:
	$HUD.show_level_complete()


# Player pressed Continue button, so the next level should load 
func _on_continue_requested() -> void:
	var next_path := _get_next_level()
	if next_path.is_empty():
		_on_menu_requested()   # no more levels
		return
	_load_level(next_path)
	$HUD.hide()


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
	$HUD.update_score(score)
	get_tree().call_group("mobs", "queue_free")

func _on_score_timer_timeout() -> void:
	score += 1
	$HUD.update_score(score)


func _on_start_timer_timeout() -> void:
	$MobTimer.start()
	$ScoreTimer.start()


# Handle dialogic events
func _on_area_event_area_entered(dialog_name) -> void:
	if Dialogic.current_timeline != null:
		return
	Dialogic.start(dialog_name)
