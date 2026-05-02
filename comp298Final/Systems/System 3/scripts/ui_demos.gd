extends Node2D


@onready var pause_menu: PopupPanel = $PauseMenu
@onready var game_speed_indicator: Label = $GameSpeedIndicator

var seconds_passed: float = 0.0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func _physics_process(delta: float) -> void:
	seconds_passed += 1*delta
	game_speed_indicator.text = "%0.1f s" % seconds_passed
	

func _on_test_pause_button_pressed() -> void:
	pause_menu.visible = true
