class_name MovePieceState
extends State

@export var actor = CharacterBody2D
var squares_set: bool = false

signal piece_is_inactive
signal target_pos_is_piece
	
func move_piece() -> void:
	var final_pos: Vector2
	final_pos = actor.mouse_pos
	
	if Input.is_action_just_pressed("left_click"):
		
		for square in get_children():
			#si la pieza a matar existe y no es la que estoy moviendo entonces la mato
			#if Global.target_piece and Global.target_piece != actor and Global.target_piece.team != actor.team:
			#	Global.target_piece.queue_free()
			
			#muevo la pieza solo si su posicion coincide con los cuadrados
			
			
			if actor.isActive and Global.board.local_to_map(square.global_position) == Global.board.local_to_map(final_pos):
				set_invisible_squares()
				#print(is_path_clear(actor.board.local_to_map(square.global_position), actor.board.local_to_map(final_pos)))
				var tween: Tween = get_tree().create_tween()
				#actor.global_position = actor.board.local_to_map(final_pos) * 64
				tween.tween_property(actor, "position", Vector2(Global.board.local_to_map(final_pos) * 64), 0.5)
				await tween.finished
				
				
				actor.isActive = false
				#cambio a null la pieza seleccionada en el global despues de mover
				Global.selected_piece = null
				if actor is Pawn:
					actor.movement = 1
			
			actor.final_pos = Global.board.local_to_map(final_pos)
			#limpio las posiciones ocupadas despues de mover
			Global.occupied_positions.clear()


#esta funcion tengo que modificarla para que en lugar de calcular aca los espacios
#cada clase tenga su metodo y lo llamo aca pero bueno por ahora queda asi
func set_movement_tiles() -> void:
	var position_offset: Vector2 = Vector2(32,32)
	var piece_pos: Vector2 = actor.global_position
	var space_moved: int = 64
	
	if !squares_set:
		for movement in actor.movement:
			
			var square_instance = load("res://scenes/square.tscn").instantiate()
			#tomo la posicion de la pieza en movimiento y le sumo 64 pixels de espacio
			#porque eso simula la distancia de un cuadrado de movimiento
			#los 64 espacios se multiplican por la cantidad de movimiento de la pieza
			#en este caso el peon se mueve hasta dos epsacios porlo que loopeo la cantidad
			#de movimientos o sea 2 y hago dos iteraciones que concluyee en los dos espacios de adelante
			#si el peon sube se multiplica en negativo pero si baja seria en positivo

			var positions: Array = []
			match actor.name.substr(0, 4):
				
				#PEON
				"peon":
					if actor.team == "blue":
						positions.append((piece_pos + position_offset) + Vector2(0, -space_moved * (movement + 1)))
					else:
						positions.append((piece_pos + position_offset) + Vector2(0, space_moved * (movement + 1)))
				#CABALLO
				"caba":
					#directamente se calcula la posicion final, no se agregan los demas cuadrados
					positions.append((piece_pos + position_offset) + Vector2(space_moved * 2, space_moved * 1))   # Right-Down
					positions.append((piece_pos + position_offset) + Vector2(space_moved * 2, -space_moved * 1))  # Right-Up
					positions.append((piece_pos + position_offset) + Vector2(-space_moved * 2, space_moved * 1))  # Left-Down
					positions.append((piece_pos + position_offset) + Vector2(-space_moved * 2, -space_moved * 1)) # Left-Up
					positions.append((piece_pos + position_offset) + Vector2(space_moved * 1, space_moved * 2))   # Down-Right
					positions.append((piece_pos + position_offset) + Vector2(-space_moved * 1, space_moved * 2))  # Down-Left
					positions.append((piece_pos + position_offset) + Vector2(space_moved * 1, -space_moved * 2))  # Up-Right
					positions.append((piece_pos + position_offset) + Vector2(-space_moved * 1, -space_moved * 2)) # Up-Left
				
				#ROOK
				"rook":
					for i in range(1, movement + 1):
						positions.append((piece_pos + position_offset) + Vector2(0, -space_moved * i))  # Up
						positions.append((piece_pos + position_offset) + Vector2(0, space_moved * i))   # Down
						positions.append((piece_pos + position_offset) + Vector2(-space_moved * i, 0)) # Left
						positions.append((piece_pos + position_offset) + Vector2(space_moved * i, 0))  # Right

				#KING
				"king":
					
					#le sumo uno porque algo hace que incluso si el movement es 1 lo vuelva 0
					#asi que le pongo 2 y fue
					for i in range(1, movement + 2):
						positions.append((piece_pos + position_offset) + Vector2(0, -space_moved * i))  # Up
						positions.append((piece_pos + position_offset) + Vector2(0, space_moved * i))   # Down
						positions.append((piece_pos + position_offset) + Vector2(-space_moved * i, 0)) # Left
						positions.append((piece_pos + position_offset) + Vector2(space_moved * i, 0))  # Right
						positions.append((piece_pos + position_offset) + Vector2(space_moved * i, space_moved * i))  # Down Right
						positions.append((piece_pos + position_offset) + Vector2(-space_moved * i, -space_moved * i))  # Up Left
						positions.append((piece_pos + position_offset) + Vector2(-space_moved * i, space_moved * i))  # Down Left
						positions.append((piece_pos + position_offset) + Vector2(space_moved * i, -space_moved * i))  # Up Right
						
				#BISHOP
				"bish":
					for i in range(1, movement + 1):
						positions.append((piece_pos + position_offset) + Vector2(space_moved * i, space_moved * i))  # Down Right
						positions.append((piece_pos + position_offset) + Vector2(-space_moved * i, -space_moved * i))  # Up Left
						positions.append((piece_pos + position_offset) + Vector2(-space_moved * i, space_moved * i))  # Down Left
						positions.append((piece_pos + position_offset) + Vector2(space_moved * i, -space_moved * i))  # Up Right

				#QUEEN
				"quee":
						for i in range(1, movement + 2):
							positions.append((piece_pos + position_offset) + Vector2(0, -space_moved * i))  # Up
							positions.append((piece_pos + position_offset) + Vector2(0, space_moved * i))   # Down
							positions.append((piece_pos + position_offset) + Vector2(-space_moved * i, 0)) # Left
							positions.append((piece_pos + position_offset) + Vector2(space_moved * i, 0))  # Right
							positions.append((piece_pos + position_offset) + Vector2(space_moved * i, space_moved * i))  # Down Right
							positions.append((piece_pos + position_offset) + Vector2(-space_moved * i, -space_moved * i))  # Up Left
							positions.append((piece_pos + position_offset) + Vector2(-space_moved * i, space_moved * i))  # Down Left
							positions.append((piece_pos + position_offset) + Vector2(space_moved * i, -space_moved * i))  # Up Right
			
			
			#por cada posicion final se agrega una instancia de square y se le asigna una de las posiciones
			var valid_positions: Array = []
			for pos in positions:
				if pos_is_inside_map(pos) and is_path_clear(Global.board.local_to_map(pos)):
					valid_positions.append(pos)
			for pos in valid_positions:
				square_instance.position = pos
				add_child(square_instance.duplicate())
				
		
		squares_set = true

func delete_squares_set() -> void:
	squares_set = false
	for square in get_children():
		square.queue_free()

#si las elimino gnero problemas asi que las hago invisibles y despues se eliminan
func set_invisible_squares() -> void:
	for square in get_children():
		square.visible = false

#reviso si las ubicaciones para movimientos estan afuera o dentro del mapa
func pos_is_inside_map(position) -> bool:
	var converted_pos: Vector2 = Global.board.local_to_map(position)
	if converted_pos in Global.tilemap_positions:
		return true
			
	return false
			

#funcion que evita movimientos ilegales
func is_path_clear(end_pos: Vector2) -> bool:
	if actor is not Knight:
		# Get the starting position in map coordinates
		var start_pos: Vector2 = Global.board.local_to_map(actor.global_position)
		#print("Start position:", start_pos)
		#print("End position:", end_pos)

		# Compute the direction vector as an integer step
		var direction: Vector2 = (end_pos - start_pos).sign()  # -1, 0, or 1 step
		#print("Direction:", direction)

		# Initialize the current position
		var current_pos: Vector2 = start_pos + direction

		# Traverse the path to the target
		while current_pos != end_pos:
			#print("Checking position:", current_pos)

			# Check if the tile is occupied by any piece
			for piece in Global.pieces_on_board:
				var piece_pos = Global.board.local_to_map(piece.global_position)
				if Vector2(piece_pos) == current_pos:
					#print("Path blocked at:", current_pos)
					return false  # Path is blocked

			# Increment to the next position in the path
			current_pos += direction

	# If no piece blocks the path, it's clear
	return true


#reviso si las ubicaciones para movimientos coinciden con la posicion de otra pieza
func pos_is_another_piece(position) -> bool:
	var occupied_pos: Array = []
	
	var converted_pos: Vector2 = actor.board.local_to_map(position)
	
	for piece in Global.pieces_on_board:
		if piece.name == "peon":
			occupied_pos.append(actor.board.local_to_map(piece.global_position))
	print("square pos",converted_pos)
	print("pieces pos",occupied_pos[0])
	
	if converted_pos in occupied_pos:
		return false
		#delete_squares_set()
	return true
	
	#if converted_pos in Global.tilemap_positions:
		#return true
			
	#return false


func _ready():
	#con esto hago que este desactivado el fisics prouces
	
	set_physics_process(false)

func _enter_state() -> void:
	#solo se activa cuando entro al state wander
	set_physics_process(true)
	
func _exit_state() -> void:
	#cuando se sale se pone false
	set_physics_process(false)
	
	delete_squares_set()
	
func _physics_process(_delta):
	
	set_movement_tiles()
	move_piece()
	#que solo elimine los cuadrados cuando una pieza esta activa
	
	
	