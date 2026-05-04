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
var ally_side_queue: Array[BaseMove] = []

var process_queues: bool = false
var active_ally_index: int = 0

# Enemy templates for random encounters
var enemy_templates: Array = [
	preload("res://Systems/System 2/scenes/base_enemy.tscn"),
	preload("res://Systems/System 2/scenes/base_enemy.tscn"),
	preload("res://Systems/System 2/scenes/base_enemy.tscn"),
	preload("res://Systems/System 2/scenes/base_enemy.tscn")
]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# randomly make enemies here
	for i in range(min(4, enemy_templates.size())):
		var enemy = enemy_templates[i].instantiate()
		enemy_positions[i].add_child(enemy)
		enemies.append(enemy)
	
	# put allies in their places here
	for i in range(4):
		var spriteCopy
		for child in Team.team[i].get_children():
			if (child is AnimatedSprite2D) or (child is Sprite2D):
				spriteCopy = child.duplicate()
		ally_positions[i].add_child(spriteCopy)
	
	process_queues = true

func queue_move(move: BaseMove, queue: Array[BaseMove]) -> void:
	queue.append(move)

func dequeue_move(queue: Array[BaseMove]) -> BaseMove:
	return queue.pop_front()

# Apply damage on main thread
func apply_damage(target: BaseCharacter, damage: float) -> void:
	if target and not target.is_dead:
		target.health -= int(damage)

func apply_defense_change(target: BaseCharacter, amount: int) -> void:
	if target and not target.is_dead:
		target.defense += amount

func apply_attack_change(target: BaseCharacter, amount: int) -> void:
	if target and not target.is_dead:
		target.attack += amount

func apply_cooldown_change(target: BaseCharacter, amount: int) -> void:
	if target and not target.is_dead:
		target.attack_cooldown += amount

# Process moves without threading to avoid thread safety issues
func process_move(move: BaseMove, side: Array[BaseCharacter]) -> void:
	if move == null:
		return
		
	for i in range(move.num_attacks):
		# select targets
		var targets: Array[BaseCharacter] = []
		
		if move.aoe:
			for each in side:
				if not each.is_dead:
					targets.append(each)
		else:
			var alive = side.filter(func(c): return not c.is_dead)
			if alive.size() > 0:
				targets.append(alive.pick_random())
		
		# execute against targets
		for target in targets:
			if target == null or target.is_dead:
				continue
				
			if move.targets_health:
				@warning_ignore("narrowing_conversion")
				var damage = move.power * (float(move.sender.attack) / float(target.defense))
				apply_damage(target, damage)
			if move.targets_defense:
				apply_defense_change(target, -move.power)
			if move.targets_attack:
				apply_attack_change(target, -move.power)
			if move.targets_cooldown:
				apply_cooldown_change(target, move.power)

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
	
	# Process queued moves for allies
	while ally_side_queue.size() > 0 and process_queues:
		var move = dequeue_move(ally_side_queue)
		if move:
			process_move(move, Team.team)
	
	# Process queued moves for enemies
	while enemy_side_queue.size() > 0 and process_queues:
		var move = dequeue_move(enemy_side_queue)
		if move:
			process_move(move, enemies)
	
	# Handle enemies attacking
	for enemy in enemies:
		if enemy.attack_ready and enemy.health > 0 and not enemy.is_dead:
			if enemy.moveset.size() > 0:
				var move = enemy.moveset[0]
				if move and move.offensive:
					queue_move(move, enemy_side_queue)
				else:
					queue_move(move, enemy_side_queue)
				enemy.reset_cooldown()
	
	# check if all enemies are dead here (win)
	var all_enemies_dead = enemies.all(func(e): return e.is_dead)
	if all_enemies_dead and enemies.size() > 0:
		print("Victory!")
	
	# check if all allies are dead here (gameover)
	var all_allies_dead = Team.team.all(func(a): return a.is_dead)
	if all_allies_dead:
		print("Game Over!")
		
# alternate way to do this would be having move select ui grab parent to give it the move
# but I am doing it this way so that the systems are more independent and thus more transferrable
func _on_move_select_ui_index_pressed(index: int) -> void:
	var selected_move: BaseMove = move_select_ui.get_move(index)
	if selected_move and selected_move.offensive:
		queue_move(selected_move, enemy_side_queue)
	elif selected_move:
		queue_move(selected_move, ally_side_queue)
	
	move_select_ui.depopulate()
	
	if selected_move:
		selected_move.sender.reset_cooldown()

func _exit_tree() -> void:
	process_queues = false
