extends PopupPanel


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	visible = false


# a fundamental feature of the popup menu is it pausing the game when it becomes visible
# if you click outside the window or the no button, it goes away unpauses
func _on_visibility_changed() -> void:
	if visible==true:
		Engine.time_scale = 0.0
	else:
		Engine.time_scale = 1.0


func _on_yes_button_pressed() -> void:
	Engine.time_scale = 1.0
	get_tree().change_scene_to_file("res://Systems/System 3/scenes/main_menu.tscn")


func _on_no_button_pressed() -> void:
	visible = false
