extends Node

var orchynx = preload("res://Systems/System 1/scenes/Orchynx.tscn")
var fnaf = preload("res://Systems/System 1/scenes/HisNameIsFNAF.tscn")

var team: Array[BaseCharacter] = [
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
	team[2] = orchynx.instantiate()
	team[3] = fnaf.instantiate()
	
	# calling _ready manually because it's not in the scene tree or whatever
	for ally in team:
		ally._ready()
		ally.add_to_group("Ally")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	for ally in team:
		ally._process(delta)
