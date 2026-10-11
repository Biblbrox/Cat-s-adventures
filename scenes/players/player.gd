extends CharacterBody2D
class_name Player

signal hit

@export var speed = 400
var screen_size

var run_speed = 350
var jump_speed = -700
var gravity = 2500
var controlable = true

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	screen_size = get_viewport_rect().size
	hide()


func freeze_player() -> void:
	controlable = false


func unfreeze_player() -> void:
	controlable = true


func toggle_freeze():
	controlable = not controlable
	if not controlable:
		velocity = Vector2.ZERO


func get_input():
	velocity.x = 0
	if not controlable:
		return
	var right = Input.is_action_pressed('ui_right')
	var left = Input.is_action_pressed('ui_left')
	var jump = Input.is_action_just_pressed('ui_select')

	if is_on_floor() and jump:
		velocity.y = jump_speed
	if right:
		velocity.x += run_speed
	if left:
		velocity.x -= run_speed

func handle_gravity(delta):
	velocity.y += gravity * delta
	get_input()
	move_and_slide()

func _physics_process(delta):
	# happens at a fixed rate, 60 times per second by default. This is independent of your 
	# game's actual framerate, and keeps physics running smoothly. You should use it for anything
	# that involves the physics engine, like moving a body that collides with the environment.
	handle_gravity(delta)

	if velocity.x != 0:
		$AnimatedSprite2D.flip_h = velocity.x > 0
		if velocity.y == 0:
			$AnimatedSprite2D.animation = "walk"
		else:
			$AnimatedSprite2D.stop()
		$AnimatedSprite2D.play()
	elif velocity.y != 0:
		$AnimatedSprite2D.animation = "up"
		$AnimatedSprite2D.play()
	else:
		$AnimatedSprite2D.stop()


func play_animation(animation_name):
	if animation_name == "walk_left":
		$AnimatedSprite2D.flip_h = true
		$AnimatedSprite2D.animation = "walk"
		$AnimatedSprite2D.play()
	elif animation_name == "walk_right":
		$AnimatedSprite2D.flip_h = false
		$AnimatedSprite2D.animation = "walk"
		$AnimatedSprite2D.play()
	elif animation_name == "idle":
		$AnimatedSprite2D.animation = "idle"
		$AnimatedSprite2D.play()


func start(pos):
	position = pos
	show()
	#$CollisionShape2D.disabled = false


func _on_body_entered(body: Node2D) -> void:
	return
	#hide()
	#hit.emit()
	#$CollisionShape2D.set_deferred("disabled", true)
