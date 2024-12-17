extends PassiveSkill


# Called when the node enters the scene tree for the first time.
func _ready():
	super._ready()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	super._process(delta)
	activate_passive_skill()

func activate_passive_skill() -> void:
	# Clear previous states to start fresh
	for piece in Global.pieces_on_board:
		if piece is Pawn and piece.team == actor.team:
			piece.states.erase(self.skill_name)
	
	# Iterate over all pieces to check for neighbors
	for piece in Global.pieces_on_board:
		if piece is Pawn and piece.team == actor.team:
			var piece_pos: Vector2 = Global.board.local_to_map(piece.global_position)
			var left_pos: Vector2 = piece_pos + Vector2(-1, 0)
			var right_pos: Vector2 = piece_pos + Vector2(1, 0)
			
			for other_piece in Global.pieces_on_board:
				if other_piece == piece:
					continue  # Skip itself
				
				var other_pos: Vector2 = Global.board.local_to_map(other_piece.global_position)
				
				# If an adjacent pawn is found, add the state
				if other_piece is Pawn and other_piece.team == actor.team and \
					(other_pos == left_pos or other_pos == right_pos):
					if self.skill_name not in piece.states:
						set_state_on_piece(piece)
					break  # No need to check further neighbors for this piece

			
	#print(piece_pos.x - 1)
	#print(piece_pos.x + 1)
	#print("left :", Global.board.local_to_map(actor.position))
	
