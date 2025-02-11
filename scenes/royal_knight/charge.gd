extends ActiveSkill

# Called when the node enters the scene tree for the first time.
func _ready():
	super._ready()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	super._process(delta)



func skill_action() -> void:
	#falta agregar empuje
	#falta agregar que se quede en la casilla anterior y no en la del objetivo
	#falta agregar que solo se pueda usar si esta despejado el camino
	
	start_move_tween(calculate_final_pos(Global.target_piece.position))
	
func start_move_tween(final_pos) -> void:
	if is_path_clear(final_pos):
		var tween: Tween = get_tree().create_tween()				
		tween.tween_property(actor, "position", Vector2(Global.board.local_to_map(final_pos) * 64), 0.3)
		await tween.finished
	
	else:
		print("camino bloqueado")

func is_path_clear(end_pos: Vector2) -> bool:
	
	# Get the starting position in map coordinates
	var start_pos: Vector2 = Global.board.local_to_map(actor.global_position)

	# Compute the direction vector as an integer step
	var direction: Vector2 = (end_pos - start_pos).sign()  # -1, 0, or 1 step

	# Initialize the current position
	var current_pos: Vector2 = start_pos + direction

	# Traverse the path to the target
	while current_pos != end_pos:

		# Check if the tile is occupied by any piece
		for piece in Global.pieces_on_board:
			var piece_pos = Global.board.local_to_map(piece.global_position)
			if Vector2(piece_pos) == current_pos:
				
				return false  # Path is blocked

		# Increment to the next position in the path
		current_pos += direction

	# If no piece blocks the path, it's clear
	return true

func calculate_final_pos(target_pos: Vector2) -> Vector2:
	var start_pos: Vector2 = Global.board.local_to_map(actor.position)
	var final_pos: Vector2 = Global.board.local_to_map(target_pos)
	var pos_dif: Vector2 = start_pos - final_pos
	
	# calcula de donde viene el movimiento y donde termina
	#para ajustar el posicionamiento de la pieza y que no
	#termine encima de la pieza objetivo sino un lugar antes
	
	if pos_dif.x > 0:
		final_pos += Vector2(1, 0)  # Moving left, stop 1 tile before
	elif pos_dif.x < 0:
		final_pos -= Vector2(1, 0)  # Moving right, stop 1 tile before
	elif pos_dif.y > 0:
		final_pos += Vector2(0, 1)  # Moving up, stop 1 tile before
	elif pos_dif.y < 0:
		final_pos -= Vector2(0, 1)  # Moving down, stop 1 tile before
	
	return Global.board.map_to_local(final_pos)
	
	
	
	
	
