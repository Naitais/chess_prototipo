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
			sprite.self_modulate = Color(1,2,1)
			actor.isActive = true
			
			#guardo la posicion inicial de la pieza
			actor.initial_pos = Global.board.local_to_map(actor.global_position)
			emit_signal("piece_is_selected")
	
		

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
	
	
