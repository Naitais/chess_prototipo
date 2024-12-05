class_name ReceiveDamageState
extends State

@export var actor = CharacterBody2D
@export var sprite = Sprite2D

signal piece_not_hovered
signal piece_attack_finished

#funciona bien pero esta checkeando por piezas que no corresponde porque me tira fuera de rango
#incluso cuando esta en rango
func receive_damage() -> void:
	
	#el ataque solo funciona si el jugador de la pieza no ataco en su turno actual
	if Global.selected_piece and Input.is_action_just_pressed("left_click") and !Global.selected_piece.jugador.ataque_realizado and Global.selected_piece.jugador.team == Global.turn:
		
		#daño realizado lo saco del attack damage de la pieza que ataca
		var damage_taken: int = Global.selected_piece.physical_damage
		
		#obtengo las posiciones de rango melee del atacante
		var posiciones_off_del_atacante: Array = Global.selected_piece.posiciones_de_ataque #pos ofensivas
		
		#obtengo la posicion de la pieza atacada
		var pos_actual: Vector2 = Global.board.local_to_map(actor.global_position)
		
		#reviso que la pieza atacada esta en rango de la pieza atacante
		for posicion in posiciones_off_del_atacante: #reviso cada posicion of y si coincide con la pieza clickeada
			if posicion == pos_actual:  			 #entonces hace daño
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
				
				#despues de realizar el ataque, seteo variable del jugador en true
				Global.selected_piece.jugador.ataque_realizado = true
				
				#actualizo label de la accion del jugador
				Global.selected_piece.jugador.update_player_labels()
				
		#actualizo los stats de la pieza atacada
		actor.set_stats()
		
		#si la pieza murio, muevo la pieza atacante al lugar de la pieza muerta
		move_piece_to_killed_piece_pos(pos_actual,Global.selected_piece)
		
		#despues de atacar deselecciono la pieza
		Global.selected_piece.deselect_piece_no_click()
		
func highlight_hovered_piece() -> void:
	#highlight the hovered piece to be attacked
	if !actor.isActive:
		sprite.self_modulate = Color(1,1,1)

func move_piece_to_killed_piece_pos(killed_piece_pos: Vector2, attacker: Piece) -> void:
	
	if actor.health <= 0:
		#ejecuto tween para mover la pieza a la posicion de la pieza que murio
		var tween: Tween = get_tree().create_tween()				
		tween.tween_property(attacker, "position", killed_piece_pos * 64, 0.5)
		await tween.finished

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
	
