extends ActiveSkill

# Called when the node enters the scene tree for the first time.
func _ready():
	super._ready()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	super._process(delta)

func skill_action() -> void:
	#falta agregar empuje
	start_move_tween(calculate_final_pos(Global.target_piece.position))

func cast_skill() -> void:
	var final_pos = calculate_final_pos(Global.target_piece.position)
	
	if not is_path_clear(final_pos):
		#TODO CUANDO EL CABALLO ESTA AL LADO NO ME DEJA TIRA PATH BLOCKED
		#SEGURO ES PORQUE EL CALCULO COINCIDA Y FLASHA QUE ESTA OCUPADO
		print("Skill blocked: path is not clear")
		return  # Exit the function early

	# If path is clear, proceed with casting
	if actor.active_skill.tipo == "fisico_melee":
		actor.active_skill.choose_target_state.emit_signal("skill_executed")
		Global.target_piece.aplicar_daño(damage, "fisico")

	elif tipo == "buff_debuff_rango":
		_pieza = Global.target_piece
		choose_target_state.emit_signal("skill_executed")

	skill_action()
func start_move_tween(final_pos) -> void:
	if is_path_clear(final_pos):
		
		var tween: Tween = get_tree().create_tween()				
		tween.tween_property(actor, "position", Vector2(Global.board.local_to_map(final_pos) * 64), 0.3)
		await tween.finished
	else:
		print("blocked")

func is_path_clear(final_pos) -> bool:
	final_pos = Global.board.local_to_map(final_pos)  # Ensure we're using map coordinates
	var start_pos: Vector2 = Global.board.local_to_map(actor.position)
	
	#para determinar si estoy usando la habilidad al lado de la pieza o no
	#porque sino considera que si esta al lado el camino esta bloqueado
	#porque coincide la pos final con la de una pieza
	var distance: float = start_pos.distance_to(final_pos)
	
	for piece in Global.pieces_on_board_dict.keys():
		if Global.pieces_on_board_dict[piece] == Vector2(final_pos) and distance > 0:
			
			return false  # Position is occupied
			
	return true  # No piece found, path is clear

func calculate_final_pos(target_pos: Vector2) -> Vector2:
	var start_pos: Vector2 = Global.board.local_to_map(actor.position)
	var final_pos: Vector2 = Global.board.local_to_map(target_pos)
	
	var direction: Vector2 = (final_pos - start_pos).normalized() # Get direction as unit vector
	var distance: float = start_pos.distance_to(final_pos)
	
	# If distance is more than 1 tile, move only (distance - 1) towards target
	if distance > 1:
		final_pos = start_pos + direction * (distance - 1)
		return Global.board.map_to_local(final_pos)
	#si la distancia es 1 entonces dejo la pieza en el mismo lugar sin moverla
	else:
	
		return Global.board.map_to_local(start_pos)
