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
		print(actor)
		#daño realizado lo saco del attack damage de la pieza que ataca
		var damage_taken: int = Global.selected_piece.physical_damage
		#pieza atacante
		var pieza_atacante: Piece = Global.selected_piece
		#pos ofensivas
		var posiciones_off_del_atacante: Array = pieza_atacante.posiciones_de_ataque 
		#obtengo la posicion de la pieza atacada
		var pos_actual: Vector2 = Global.board.local_to_map(actor.global_position)
		
		
		
		#reviso cada posicion ofensiva y si el actor esta en una de esas, entonces esta en rango de ataque
		
		if pos_actual in posiciones_off_del_atacante and not pieza_atacante.isCastingSkill:
			
			
			
			#TODO
			#agregar bandera que detecte que tipó de skill es, si es una ofensiva melee
			#si fuera rango facilmente se puede editar las casillas en el state choose target de la skill
			#para agregar posiciones ofensivas de rango
			#tambien tener en cuenta que si una posicion rango esta en rango melee no puede usar skills
			#de rango asi estan en desventaja como en el heroes
			
				
				
					
			
				#en este caso es daño fisico asi que el escudo es la armadura
			actor.aplicar_daño(damage_taken, "fisico")
				#reduzco mana en 1
			pieza_atacante.jugador.deplete_mana(1)
				#si la pieza murio, muevo la pieza atacante al lugar de la pieza muerta
			move_piece_to_killed_piece_pos(pos_actual,Global.selected_piece)
			Global.selected_piece.deselect_piece_no_click()
				
			
				
				
				
		
		if actor in pieza_atacante.active_skill.pieces_in_range and pieza_atacante.isCastingSkill:
			
			#si la skill es fisico melee
			if pieza_atacante.active_skill.tipo == "fisico_melee":
				var skill_damage: int = pieza_atacante.active_skill.damage
				var skill_mana_cost: int = pieza_atacante.active_skill.mana_cost
				
				pieza_atacante.active_skill.choose_target_state.emit_signal("skill_executed")
				actor.aplicar_daño(skill_damage, "fisico")
					
			elif pieza_atacante.active_skill.tipo == "buff_debuff_rango":
				var skill_mana_cost: int = pieza_atacante.active_skill.mana_cost
				
				#seteo la pieza objetivo de la skill puede ser aliada o enemigo
				pieza_atacante.active_skill._pieza = actor
				pieza_atacante.active_skill.choose_target_state.emit_signal("skill_executed")
				
		
		
		#await get_tree().create_timer(1.0).timeout #espero un segundo para mostrar label de skill casteada
		#despues de atacar deselecciono
		
		
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
		   and Global.selected_piece.jugador.team == TurnManager.turn

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
	
