extends CanvasLayer

signal continue_requested
signal menu_requested

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func show_message(text):
	$Message.text = text
	$Message.show()
	$MessageTimer.start()

func show_game_over():
	show_message("Game over")
	await $MessageTimer.timeout
	
	$Message.text = "Dodge the Creeps!"
	$Message.show()
	
	await get_tree().create_timer(1.0).timeout

func show_level_complete():
	$LevelComplete.show()


func update_score(score):
	pass


func _on_continue_pressed() -> void:
	$LevelComplete.hide()
	continue_requested.emit()


func _on_menu_pressed() -> void:
	menu_requested.emit()

func _on_message_timer_timeout() -> void:
	$Message.hide()
