extends PopupMenu

@onready var current_items: Array[BaseMove] = []

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


func populate(moveset: Array[BaseMove]) -> void:
	for move in moveset:
		add_item(move.name)
		current_items.append(move)
	visible = true

func depopulate() -> void:
	clear()
	current_items = []
	visible = false # this line is kind of redundant because hide on item select is true

func get_move(index: int) -> BaseMove:
	return current_items[index]
