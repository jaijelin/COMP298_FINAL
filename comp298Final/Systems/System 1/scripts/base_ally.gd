extends BaseCharacter
class_name BaseAlly


@export var move_1: BaseMove
@export var move_2: BaseMove
@export var move_3: BaseMove

func _ready() -> void:
	moveset = [
	move_1,
	move_2,
	move_3
	]
	super._ready()
	
func _process(delta: float) -> void:
	# all the super does is count the time since last attack
	super._process(delta)

func die() -> void:
	super.die()
	
