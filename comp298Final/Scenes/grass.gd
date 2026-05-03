extends Node2D

@onready var anim_player = $AnimationPlayer

# Called when the node enters the scene tree for the first time.
func _ready():
	pass
	
	
func _on_area_2d_body_entered(body: Node2D) -> void:
	
	#print("GRASSSSSSSSSSSSSSSSSSSSSSS")
	anim_player.play("Stepped")
	
	
