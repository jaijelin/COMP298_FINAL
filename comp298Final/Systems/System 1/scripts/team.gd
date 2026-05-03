extends Node

var orchynx = preload("res://Systems/System 1/scenes/Orchynx.tscn")
var fnaf = preload("res://Systems/System 1/scenes/HisNameIsFNAF.tscn")

var team: Array[BaseAlly] = [
	BaseAlly.new(),
	BaseAlly.new(),
	BaseAlly.new(),
	BaseAlly.new()
]

# who goes in the team (including any possible future implementation of changing team composition) should be handled by this script

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	team[0] = orchynx.instantiate()
	team[1] = fnaf.instantiate()
	
	for ally in team:
		ally.add_to_group("Ally")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
