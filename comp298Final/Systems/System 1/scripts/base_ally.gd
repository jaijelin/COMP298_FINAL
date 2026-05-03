extends BaseCharacter
class_name BaseAlly

var moves = []

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
	
