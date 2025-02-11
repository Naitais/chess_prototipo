extends ActiveSkill

var path_blocked: bool = false

# Called when the node enters the scene tree for the first time.
func _ready():
	super._ready()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	super._process(delta)
	



func skill_action() -> void:
	#falta agregar empuje
	#falta agregar que solo se pueda usar si esta despejado el camino
	
	start_move_tween(calculate_final_pos(Global.target_piece.position))
	
func start_move_tween(final_pos) -> void:
	
	var tween: Tween = get_tree().create_tween()				
	tween.tween_property(actor, "position", Vector2(Global.board.local_to_map(final_pos) * 64), 0.3)
	await tween.finished

#usar lo de abajo para ver que onda si se puede o no mover a esa posicion
#igual deberia poder usar occupied tiles creo

#for piece in Global.pieces_on_board:
#				var piece_pos = Global.board.local_to_map(piece.global_position)
#				if Vector2(piece_pos) == current_pos:


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
