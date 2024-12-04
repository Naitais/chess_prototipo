class_name SelectPieceState
extends State

@export var sprite = Sprite2D
@export var actor = Piece


signal piece_not_hovered
signal piece_is_selected

#selecciono y activo una pieza
func select_piece() -> void:
	if Global.selected_piece == null:
		if Input.is_action_just_pressed("left_click"):
			
			Global.selected_piece = actor
			set_offensive_squares()
			#despues de hacerle click aumento mas inlcuso el color de la pieza para enfasis
			sprite.self_modulate = Color(1,2,1)
			actor.isActive = true
			
			#guardo la posicion inicial de la pieza
			actor.initial_pos = Global.board.local_to_map(actor.global_position)
			emit_signal("piece_is_selected")

#setea los espacios de cada pieza en los cuales puede detectar piezas enemigas para atacar
func set_offensive_squares() -> void:
	#actor.posiciones_de_ataque
	actor.posiciones_de_ataque.clear()
	# TODO AGREGAR LOGICA PARA QUE SI UNA ESTADISTICA ESTA EN 0 QUE NO LA MUESTRE PORQUE ES RUIDOSO A LA VISTA
	# DAMOS POR SENTADO QUE SI ESTA EN 0 NO TIENE ESA PROPIEDAD ACTIVA
	var pos_actual: Vector2 = Global.board.local_to_map(actor.global_position)
	if actor is Queen or actor is Knight or actor is King:
		
		actor.posiciones_de_ataque.append(pos_actual+Vector2(0,-1)) #up
		actor.posiciones_de_ataque.append(pos_actual+Vector2(0,1)) #down
		actor.posiciones_de_ataque.append(pos_actual+Vector2(-1,0)) #left
		actor.posiciones_de_ataque.append(pos_actual+Vector2(1,0)) #right
		actor.posiciones_de_ataque.append(pos_actual + Vector2(-1, -1)) # top-left
		actor.posiciones_de_ataque.append(pos_actual + Vector2(1, -1))  # top-right
		actor.posiciones_de_ataque.append(pos_actual + Vector2(-1, 1))  # bottom-left
		actor.posiciones_de_ataque.append(pos_actual + Vector2(1, 1))   # bottom-right
	
	elif actor is Pawn and actor.team == "blue":
		actor.posiciones_de_ataque.append(pos_actual + Vector2(-1, -1)) # top-left
		actor.posiciones_de_ataque.append(pos_actual + Vector2(1, -1))  # top-right
		
	elif actor is Pawn and actor.team == "red":
		actor.posiciones_de_ataque.append(pos_actual + Vector2(-1, 1))  # bottom-left
		actor.posiciones_de_ataque.append(pos_actual + Vector2(1, 1))   # bottom-right
	
	elif actor is Rook:
		actor.posiciones_de_ataque.append(pos_actual+Vector2(0,-1)) #up
		actor.posiciones_de_ataque.append(pos_actual+Vector2(0,1)) #down
		actor.posiciones_de_ataque.append(pos_actual+Vector2(-1,0)) #left
		actor.posiciones_de_ataque.append(pos_actual+Vector2(1,0)) #right
	
	elif actor is Bishop:
		actor.posiciones_de_ataque.append(pos_actual + Vector2(-1, -1)) # top-left
		actor.posiciones_de_ataque.append(pos_actual + Vector2(1, -1))  # top-right
		actor.posiciones_de_ataque.append(pos_actual + Vector2(-1, 1))  # bottom-left
		actor.posiciones_de_ataque.append(pos_actual + Vector2(1, 1))   # bottom-right
		
#con esta funcion saco color opaco a la pieza que estoy hovereando
func highlight_hovered_piece() -> void:
	if !actor.isActive:
		sprite.self_modulate = Color(1,1,1)
	

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
	if Global.turn == actor.team:
		#print("es mi turno", actor.team)
		select_piece()
		highlight_hovered_piece()
		
	
