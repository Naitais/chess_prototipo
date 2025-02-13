extends ActiveSkill



# Called when the node enters the scene tree for the first time.
func _ready():
	super._ready()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	super._process(delta)
	



func skill_action() -> void:
	#falta agregar empuje
	#falta agregar que solo se pueda usar si esta despejado el camino
	print(Global.pieces_on_board_dict)
	start_move_tween(calculate_final_pos(Global.target_piece.position))
	
func start_move_tween(final_pos) -> void:
	if is_path_clear_new(final_pos):
		var tween: Tween = get_tree().create_tween()				
		tween.tween_property(actor, "position", Vector2(Global.board.local_to_map(final_pos) * 64), 0.3)
		await tween.finished
	else:
		print("blocked")


func is_path_clear(final_pos) -> bool:
	var start_pos: Vector2 = Global.board.local_to_map(actor.position)
	#TODO UTILIZAR DICCIONARIO NUEVO CON INFO ACTUALIZADA DE CADA PIEZA
	print(Global.pieces_on_board_dict)
	for piece in Global.pieces_on_board:
			var piece_pos = Global.board.local_to_map(piece.global_position)
			final_pos = Global.board.local_to_map(final_pos)
			if final_pos != piece_pos:
				return true
			
			
				
			#print(piece," ",piece_pos)
			#print("pos final ", final_pos)
	return false
#usar lo de abajo para ver que onda si se puede o no mover a esa posicion
#igual deberia poder usar occupied tiles creo



#func calculate_final_pos(target_pos: Vector2) -> Vector2:
	#var start_pos: Vector2 = Global.board.local_to_map(actor.position)
	#var final_pos: Vector2 = Global.board.local_to_map(target_pos)
	#var pos_dif: Vector2 = start_pos - final_pos
	#
	## Adjust final position to stop 1 tile before target
	#if pos_dif.x > 0:
		#final_pos += Vector2(1, 0)  # Moving left, stop 1 tile before
	#elif pos_dif.x < 0:
		#final_pos -= Vector2(1, 0)  # Moving right, stop 1 tile before
	#elif pos_dif.y > 0:
		#final_pos += Vector2(0, 1)  # Moving up, stop 1 tile before
	#elif pos_dif.y < 0:
		#final_pos -= Vector2(0, 1)  # Moving down, stop 1 tile before
	#
	#return Global.board.map_to_local(final_pos)
#


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

func is_path_clear_new(end_pos: Vector2) -> bool:
	# Convert positions to board coordinates
	var start_pos: Vector2 = Global.board.local_to_map(actor.position)
	var target_pos: Vector2 = Global.board.local_to_map(end_pos)

	# Compute movement direction as -1, 0, or 1
	var direction: Vector2 = Vector2(
		sign(target_pos.x - start_pos.x),
		sign(target_pos.y - start_pos.y)
	)

	# Start at the first step
	var current_pos: Vector2 = start_pos + direction

	print("Checking path from ", start_pos, " to ", target_pos, " with direction ", direction)

	# Traverse the path until reaching the last step before the target
	while current_pos != target_pos:
		print("Checking position: ", current_pos)
		
		# Check if any piece is at the current position
		for piece in Global.pieces_on_board:
			var piece_pos = Global.board.local_to_map(piece.position)
			if piece_pos == current_pos:
				print("Path blocked by piece at ", piece_pos)
				return false  # Path is blocked

		# Move to the next tile
		current_pos += direction

	print("Path is clear!")
	return true
