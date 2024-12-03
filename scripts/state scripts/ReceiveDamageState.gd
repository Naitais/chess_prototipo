class_name ReceiveDamageState
extends State

@export var actor = CharacterBody2D
@export var sprite = Sprite2D

signal piece_not_hovered

func receive_damage() -> void:
	if Global.selected_piece and Input.is_action_just_pressed("left_click"):
		var damage_taken: int = Global.selected_piece.physical_damage
		
		if actor.armor > 0:
			# Subtract damage from armor first
			var damage_to_armor = min(damage_taken, actor.armor)  # Only reduce armor by the amount it has
			actor.armor -= damage_to_armor
			
			# Calculate remaining damage after armor
			var rest_damage = damage_taken - damage_to_armor
			actor.health -= rest_damage
		else:
			# If no armor, apply all damage to health
			actor.health -= damage_taken
		
		actor.set_stats()  # Update stats

			
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
	
