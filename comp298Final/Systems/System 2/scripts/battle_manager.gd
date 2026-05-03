extends Control

@onready var enemy_pos_1: Marker2D = $EnemyPos1
@onready var enemy_pos_2: Marker2D = $EnemyPos2
@onready var enemy_pos_3: Marker2D = $EnemyPos3
@onready var enemy_pos_4: Marker2D = $EnemyPos4
@onready var enemy_positions: Array[Marker2D] = [
	enemy_pos_1,
	enemy_pos_2,
	enemy_pos_3,
	enemy_pos_4
]

@onready var ally_pos_1: Marker2D = $AllyPos1
@onready var ally_pos_2: Marker2D = $AllyPos2
@onready var ally_pos_3: Marker2D = $AllyPos3
@onready var ally_pos_4: Marker2D = $AllyPos4
@onready var ally_positions: Array[Marker2D] = [
	ally_pos_1,
	ally_pos_2,
	ally_pos_3,
	ally_pos_4
]

var enemy_side_queue = []
var enemy_side_thread: Thread

var ally_side_queue = []
var ally_side_thread: Thread


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# randomly make enemies here
	
	# put allies in their places here
	for i in range(4):
		var spriteCopy
		for child in Team.team[i].get_children():
			if (child is AnimatedSprite2D) or (child is Sprite2D):
				spriteCopy = child.duplicate()
		ally_positions[i].add_child(spriteCopy)
	
	
	# create threads
	enemy_side_thread = Thread.new()
	ally_side_thread = Thread.new()

# some ideas for tomorrow
# make the move select ui
# make an index var
# process should, if there move select ui isn't visible, increment the index and check if it is ready to attack
# now, as for the move being sent into the queue
# you click a button in the move select ui
# the ui grabs pareent (battle manager) and sends it the move
# there should prolly be a function within battle manager to package that movee and send it to the right thread 

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
