extends PassiveSkill

#LA PROXIMA VOY A USAR UN AREA2D EN LUGAR DE USAR LAS POSICIONES DEL MAPA PORQUE SE BUGEA
#O SEA PARA DETECTAR LOS PEONES A LOS COSTADOS DIGO

var ally_near_pawns: Array
var passive_activated: bool = false #cuando se activa el pasivo se tiene que cambiar a inactive
									#state de nuevo

# Called when the node enters the scene tree for the first time.
func _ready():
	super._ready()
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	super._process(delta)
	activate_passive_skill()
	
	#check_neighbors()
#deactivates passive if panws are no longer near each other
#func deactivate_passive_skill() -> void:

func activate_passive_skill() -> void:
	var actor_pos: Vector2 = Global.board.local_to_map(actor.global_position)
	var left_pos: Vector2 = actor_pos + Vector2(-1, 0) #posicion a la izq de la pieza que castea el pasivo
	var right_pos: Vector2 = actor_pos + Vector2(1, 0) #posicion a la der de la pieza que castea el pasivo
	
	# Iterate over all pieces to check for neighbors
	for piece in Global.pieces_on_board:
		if piece is Pawn and piece.team == actor.team and piece != actor:
			var piece_pos: Vector2 = Global.board.local_to_map(piece.global_position)
			
			if piece_pos == left_pos or piece_pos == right_pos:
				if piece not in ally_near_pawns:
					ally_near_pawns.append(piece)
					inactive_passive_state.emit_signal("passive_activated")
				#agrego la pieza a array solo si la pieza no fue agregada todavia
				
				# primero antes de seguir asegurarme que al dejar de estar
				# adyacente, la pieza es eliminada
				# cuando vuelve a estar adyacente que sea agregada
				# luego de tener eso funcionando hacer lo de agregar el efecto
			else:
				
				#print(piece)
				if piece in ally_near_pawns:
					
					#aca deberia tener una bandera que determine si la pieza ya recibio daño
					#mientras el pasivo esta activo, si es asi entonces remuevo el pasivo
					#pero sin restar a 1 la armadura porque sino lo estaria restando dos veces
					#una por haber recibido daño y otra por sacarle el escudo
					ally_near_pawns.erase(piece)
					remove_effect(piece) 
					
			
	
	
	
func check_neighbors() -> void:
	var actor_pos: Vector2 = Global.board.local_to_map(actor.global_position)
	var left_pos: Vector2 = actor_pos + Vector2(-1, 0)
	var right_pos: Vector2 = actor_pos + Vector2(1, 0)
	
	# Iterate over current allies in the array
	for piece in ally_near_pawns.duplicate():  # Use duplicate() to avoid modifying while iterating
		var piece_pos: Vector2 = Global.board.local_to_map(piece.global_position)
		# If the piece is no longer adjacent, remove the passive effect
		if piece.team == actor.team and piece != actor and (piece_pos != left_pos and piece_pos != right_pos):
			
			remove_effect(piece)  # Deactivate the effect
			ally_near_pawns.erase(piece)  # Remove from the list
			
			
func remove_effect(piece: Piece) -> void:
	for child in piece.efectos.get_children():
		if child.nombre.to_lower() == "shield" and child.origen == skill_name:  # Ensure it's the right effect
			piece.efectos.remove_child(child)
			child.queue_free()  # Remove the effect node
			piece.armor -= 1
			print("a ver")
	piece.set_stats()  # Update stats to reflect the removed effect
	

			#for other_piece in Global.pieces_on_board:
			#	if other_piece == piece:
			#		continue  # Skip itself
				
			#	var other_pos: Vector2 = Global.board.local_to_map(other_piece.global_position)
				
				# If an adjacent pawn is found, add the effects
			#	if other_piece is Pawn and other_piece.team == actor.team and \
			#		(other_pos == left_pos or other_pos == right_pos):
					#ally_near_pawns.append(other_piece)
					
				#	inactive_passive_state.emit_signal("passive_activated")
			#		break  # No need to check further neighbors for this piece

			
	#print(piece_pos.x - 1)
	#print(piece_pos.x + 1)
	#print("left :", Global.board.local_to_map(actor.position))
func set_inactive_state() -> void:
	if passive_activated:
	#	active_passive_skill.emit_signal("passive_deactivated")
		pass
