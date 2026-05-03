extends BaseCharacter
class_name BaseAlly


@export var move_1: BaseMove
@export var move_2: BaseMove
@export var move_3: BaseMove

@onready var moves = [
	move_1,
	move_2,
	move_3
]


var attack_ready: bool = false

# so here's how this works
# time since attack gets reset after an attack is chosen
# the team is going to go around in a circle, checking if an attack is ready and moving on if there isn't one

func _physics_process(delta: float) -> void:
	# all the super does is count the time since last attack
	super._physics_process(delta)
	# now handle attacking
	if time_since_attack > attack_cooldown:
		attack_ready = true

func die() -> void:
	super.die()
	
