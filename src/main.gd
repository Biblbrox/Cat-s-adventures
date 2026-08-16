extends Node

@export var mob_scene: PackedScene
var score

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var level_resoure = ResourceLoader.load("res://levels/intro.tscn")
	var level = level_resoure.instantiate()
	add_child(level)
	move_child(level, 0)


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
