extends CharacterBody2D
class_name BaseCharacter


@onready var moveset: Array[BaseMove] = []

enum Type {
	ATTACKER,
	HEALER,
	BUFFER, # three stats to effect, cooldown, attack, and defense
	DEBUFFER # note: a debuff to defense must always have low power. I think 25 is good
}

@export var type: Type = Type.ATTACKER

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

var attack_ready: bool = false
var is_dead: bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# Only process moveset if it has items
	if moveset.size() > 0:
		for move in moveset:
			if move and move.has_method("_ready"):
				move._ready()

func _process(delta: float) -> void:
	if not is_dead:
		time_since_attack += 1*delta
		if time_since_attack >= attack_cooldown:
			attack_ready = true


func reset_cooldown() -> void:
	time_since_attack = 0
	attack_ready = false

# will be overriden based on enemy or ally
# but basically it should turn them into a tombstone
# and make it so they can't be healed back to life
func die() -> void:
	is_dead = true
