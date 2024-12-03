class_name ReceiveDamageState
extends State

@export var actor = CharacterBody2D
@export var sprite = Sprite2D

signal piece_not_hovered

func receive_damage() -> void:
	if Global.selected_piece:
		if Input.is_action_just_pressed("left_click"):
			actor.health -= Global.selected_piece.physical_damage
			actor.set_stats()
			
func highlight_hovered_piece() -> void:
	if !actor.isActive:
		sprite.self_modulate = Color(1,1,1)
		
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
	highlight_hovered_piece()
	receive_damage()
	
