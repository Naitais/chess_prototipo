class_name KillPieceState
extends State

@export var actor = CharacterBody2D

signal piece_is_inactive
	
func move_piece() -> void:
	var final_pos: Vector2
	final_pos = actor.mouse_pos
	
	if Input.is_action_just_pressed("left_click"):
		actor.global_position = actor.board.local_to_map(final_pos) * 64
		actor.isActive = false
	
func _ready():
	#con esto hago que este desactivado el fisics prouces
	set_physics_process(false)

func _enter_state() -> void:
	#solo se activa cuando entro al state wander
	set_physics_process(true)
	
func _exit_state() -> void:
	#cuando se sale se pone false
	set_physics_process(false)
	
func _physics_process(_delta):
	move_piece()
