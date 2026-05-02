extends Node2D
class_name BaseCharacter

enum Type {
	ATTACKER,
	HEALER,
	BUFFER,
	DEBUFFER
}

@export var type: Type

#add_to_group("Weapon")

@export var health: int:
	set(new_health):
		if new_health <= 0:
			pass # die. Idk if this will use queue free
		else:
			health = new_health

@export var attack_cooldown: int:
	set(new_cooldown):
		attack_cooldown = new_cooldown



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.
