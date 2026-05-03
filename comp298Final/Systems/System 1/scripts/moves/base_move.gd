extends Node
class_name BaseMove


@export var power: int = 1 # base power of the move, to be modified by the attack stat (buffed or debuffed)
@export var num_attacks: int = 1 # add it to queue this many times
@export var aoe: bool = false # whether to do random targetting or full team targetting
@export var offensive: bool = true # determines which queue it is added to, the one going towards the enemies or allies
@export var reflective: bool = false # probably will go unused, but determines whether self damage is taken
# ^ Could mean self damage is taken on a powerful attack, but also could mean losing health to health others

@export var sprite: String # will be a filepath
# might go unused

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.
