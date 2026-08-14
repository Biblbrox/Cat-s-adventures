extends Player

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
