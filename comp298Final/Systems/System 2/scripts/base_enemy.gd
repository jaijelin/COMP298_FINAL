extends BaseCharacter
class_name BaseEnemy


@export var move_1: BaseMove

func _ready() -> void:
	moveset = [move_1]
	super._ready()
	
func _process(delta: float) -> void:
	# all the super does is count the time since last attack
	super._process(delta)

func die() -> void:
	super.die()
	queue_free()
	
