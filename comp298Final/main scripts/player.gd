extends CharacterBody2D


signal player_moving_signal
signal player_stoped_moving

const SPEED = 300.0
const JUMP_VELOCITY = -400.0
@export var speed = 400 # Speed in pixels/sec
@onready var pause_menu: PopupPanel = $PauseMenu


func _physics_process(_delta: float) -> void:
	var direction = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	# Gets input from default UI actions (arrow keys/WASD)
	velocity = direction * speed

	if direction.x < 0:
		$AnimatedSprite2D.play("walk-left")
		emit_signal("player_moving_signal")
	elif direction.x > 0:
		$AnimatedSprite2D.play("walk-right")
		emit_signal("player_moving_signal")
	elif direction.y > 0:
		$AnimatedSprite2D.play("walk-forward")
		emit_signal("player_moving_signal")
	elif direction.y < 0:
		$AnimatedSprite2D.play("walk-back")
		emit_signal("player_moving_signal")
	else:
		$AnimatedSprite2D.play("idle") # Handle no input
		emit_signal("player_stoped_moving")
	
	
	# Sets velocity based on direction and speed
	velocity = direction * speed
	
	# Handles movement and collisions
	move_and_slide()
	

func _on_test_pause_button_pressed() -> void:
	pause_menu.visible = true
