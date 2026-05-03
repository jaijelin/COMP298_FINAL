extends Control

@onready var move_select_ui: PopupMenu = $MoveSelectUI

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

var enemies: Array[BaseCharacter] = []

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

var enemy_side_queue: Array[BaseMove] = []
var enemy_side_thread: Thread

var ally_side_queue: Array[BaseMove] = []
var ally_side_thread: Thread

var process_queues: bool = false

var active_ally_index: int = 0

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
	
	# allow their functions to do stuff
	process_queues = true
	
	# have them run constantly on their respective arrays
	enemy_side_thread.start(_process_moves.bind(enemy_side_queue, enemies))
	ally_side_thread.start(_process_moves.bind(ally_side_queue, Team.team))
	

func queue_move(move: BaseMove, queue: Array[BaseMove]) -> void:
	queue.append(move)

func dequeue_move(queue: Array[BaseMove]) -> BaseMove:
	return queue.pop_front()

# it might be smarter to put a lot of this in base_move.gd as a function
# that way more complicated moves can override it
func _process_moves(queue: Array[BaseMove], side: Array[BaseCharacter]) -> void:
	while process_queues:
		var move: BaseMove = dequeue_move(queue)
		if move != null:
			for i in range(move.num_attacks):
				
				# select targets
				var targets: Array[BaseCharacter] = []
				if move.aoe:
					for each in side:
						targets.append(each)
				else:
					targets.append(side.pick_random())
				
				# execute against targets
				for target in targets:
					if move.targets_health:
						@warning_ignore("narrowing_conversion")
						target.health -= move.power * (float(move.sender.attack) / float(target.defense))
					if move.targets_defense:
						target.defense -= move.power
					if move.targets_attack:
						target.attack -= move.power
					if move.targets_cooldown:
						target.attack_cooldown += move.power


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	Team._process(delta)

	# if the current guy is alive and can attack, do so
	if (Team.team[active_ally_index].attack_ready) and (Team.team[active_ally_index].health > 0) and (move_select_ui.visible == false):
		move_select_ui.populate(Team.team[active_ally_index].moveset)
	else:
		# increment index
		if active_ally_index == 3:
			active_ally_index = 0
		else:
			active_ally_index += 1
	
	# check if all enemies are dead here (win)
	
	
	# handle enemies here
	
	
	# check if all allies are dead here (gameover)

# alternate way to do this would be having move select ui grab parent to give it the move
# but I am doing it this way so that the systems are more independent and thus more transferrable
func _on_move_select_ui_index_pressed(index: int) -> void:
	var selected_move: BaseMove = move_select_ui.get_move(index)
	if selected_move.offensive:
		queue_move(selected_move, enemy_side_queue)
	else:
		queue_move(selected_move, ally_side_queue)
	
	move_select_ui.depopulate()
	
	selected_move.sender.reset_cooldown()


func _exit_tree() -> void:
	# it might actually be a good idea to not have this
	# could cause weird bugs where you die after winning
	process_queues = false
	enemy_side_thread.wait_to_finish()
	ally_side_thread.wait_to_finish()
