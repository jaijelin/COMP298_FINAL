extends Node2D


@onready var pause_menu: PopupPanel = $PauseMenu
@onready var game_speed_indicator: Label = $GameSpeedIndicator
@onready var move_select_ui: PopupMenu = $MoveSelectUI
@onready var test_move_select_button: Button = $TestMoveSelectButton

var seconds_passed: float = 0.0
var test_moveset: Array[BaseMove] = []

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# Create test moves for demo
	var test_move_1 = BaseMove.new()
	test_move_1.name = "Test Attack"
	test_move_1.power = 50
	test_move_1.offensive = true
	
	var test_move_2 = BaseMove.new()
	test_move_2.name = "Test Heal"
	test_move_2.power = -30
	test_move_2.offensive = false
	
	var test_move_3 = BaseMove.new()
	test_move_3.name = "Test Buff"
	test_move_3.power = 10
	test_move_3.targets_attack = true
	test_move_3.offensive = false
	
	test_moveset = [test_move_1, test_move_2, test_move_3]

func _physics_process(delta: float) -> void:
	seconds_passed += 1*delta
	game_speed_indicator.text = "%0.1f s" % seconds_passed
	
func _on_test_pause_button_pressed() -> void:
	pause_menu.visible = true

func _on_test_move_select_button_pressed() -> void:
	move_select_ui.populate(test_moveset)

func _on_move_select_ui_index_pressed(index: int) -> void:
	var selected_move = move_select_ui.get_move(index)
	print("Selected move: ", selected_move.name)
	move_select_ui.depopulate()
