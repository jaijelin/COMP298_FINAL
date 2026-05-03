extends CharacterBody2D
class_name BaseCharacter


enum Type {
	ATTACKER,
	HEALER,
	BUFFER, # three stats to effect, cooldown, attack, and defense
	DEBUFFER # note: a debuff to defense must always have low power. I think 25 is good
}

@export var type: Type = Type.ATTACKER

#add_to_group("Weapon")

@export var health: int = 100:
	set(new_health):
		if new_health <= 0:
			die() # die. Idk if this will use queue free
		else:
			health = new_health


@export var attack_cooldown: int = 5 # in seconds, so after 5 seconds it can attack
var time_since_attack = 0

# important rule, a damaging move must always deal at least 1 damage
# these stats are percentages done at 100 ints to work well with power in base_move
# damage will be calculated as move power * (your attack/its defense)
# so by default, if everyone starts with 100s then it will all cancel out (100/100=1 and 1 * power = power)
@export var defense: int = 100:
	set(new_defense):
		if new_defense < 20:
			defense = 20
		elif new_defense > 200:
			defense = 500
		else:
			defense = new_defense
@export var attack: int = 100:
	set(new_attack):
		if new_attack < 20:
			attack = 20
		elif new_attack > 200:
			attack = 200
		else:
			attack = new_attack

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func _physics_process(delta: float) -> void:
	time_since_attack += 1*delta

# will be overriden based on enemy or ally
func die() -> void:
	pass
