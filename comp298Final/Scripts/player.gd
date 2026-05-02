extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0
@export var speed = 400 # Speed in pixels/sec


func _physics_process(delta: float) -> void:
	var direction = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	# Gets input from default UI actions (arrow keys/WASD)
	velocity = direction * speed

	if direction.x < 0:
		$AnimatedSprite2D.play("walk-left")
	elif direction.x > 0:
		$AnimatedSprite2D.play("walk-right")
	elif direction.y > 0:
		$AnimatedSprite2D.play("walk-forward")
	elif direction.y < 0:
		$AnimatedSprite2D.play("walk-back")
	else:
		$AnimatedSprite2D.play("idle") # Handle no input
	
	
	# Sets velocity based on direction and speed
	velocity = direction * speed
	
	# Handles movement and collisions
	move_and_slide()
	
	
