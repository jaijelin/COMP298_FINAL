extends Node2D

@onready var anim_player = $AnimationPlayer

# Enemy spawn configuration
@export var enemy_spawn_rate: float = 1.0 #100% spawn rate for now
@export var battle_scene_path: String = "res://Systems/System 2/scenes/battle_manager.tscn"
@export var encounter_cooldown: float = 2.0

var can_encounter: bool = true
var encounter_timer: float = 0.0

func _ready():
	pass

func _process(delta: float) -> void:
	if not can_encounter:
		encounter_timer -= delta
		if encounter_timer <= 0:
			can_encounter = true

func _on_area_2d_body_entered(body: Node2D) -> void:
	#anim_player.play("Stepped")
	
	if body.name == "player" or body.is_in_group("Player"):
		_check_enemy_spawn()

func _check_enemy_spawn() -> void:
	if not can_encounter:
		return
	
	if randf() < enemy_spawn_rate:
		_trigger_battle()

func _trigger_battle() -> void:
	can_encounter = false
	encounter_timer = encounter_cooldown
	print("Enemy encountered! Starting battle...")
	# Use call_deferred to avoid physics callback error
	get_tree().call_deferred("change_scene_to_file", battle_scene_path)
