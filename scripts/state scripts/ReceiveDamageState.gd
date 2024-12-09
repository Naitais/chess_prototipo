class_name ReceiveDamageState
extends State

@export var actor = CharacterBody2D
@export var sprite = Sprite2D

signal piece_not_hovered
signal piece_attack_finished

#funciona bien pero esta checkeando por piezas que no corresponde porque me tira fuera de rango
#incluso cuando esta en rango
func receive_damage() -> void:
	
	
	if  Input.is_action_just_pressed("left_click") and check_attack_is_legal():
		
		#daño realizado lo saco del attack damage de la pieza que ataca
		var damage_taken: int = Global.selected_piece.physical_damage
		#pieza atacante
		var atacante: Piece = Global.selected_piece
		#pos ofensivas
		var posiciones_off_del_atacante: Array = atacante.posiciones_de_ataque 
		#obtengo la posicion de la pieza atacada
		var pos_actual: Vector2 = Global.board.local_to_map(actor.global_position)
		
		
		
		#reviso cada posicion ofensiva y si el actor esta en una de esas, entonces esta en rango de ataque
		if pos_actual in posiciones_off_del_atacante:
				
			if atacante.isCastingSkill:
				
				print("skill casteada por: ", atacante, " ", atacante.active_skill)
				
			else:
				#en este caso es daño fisico asi que el escudo es la armadura
				actor.aplicar_daño(damage_taken, "fisico")
				#reduzco mana en 1
				Global.selected_piece.jugador.deplete_mana(1)
				#actualizo label de la accion del jugador
				Global.selected_piece.jugador.update_player_labels()
		
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

#uso metodo para checkear is es legal el ataque para no tener todo amontonado
func check_attack_is_legal() -> bool:
	return Global.selected_piece \
		   and Global.selected_piece.jugador.mana >= 1 \
		   and Global.selected_piece.jugador.team == Global.turn

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
	
