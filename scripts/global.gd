extends Node


#var killed_piece: Piece
#var target_piece: Piece #hovered piece
var selected_piece: Piece
#var selected_target_piece: Piece
var tilemap_positions: Array = []
var occupied_positions: Array = []
var pieces_on_board: Array = []
var board: TileMap = null
var turn: String = "blue" #siempre empieza el azul
var jugadores: Array
#var game_end: bool = false
var round_counter: int = 0
#TODO
# logica de turnos
# limpiar el codigo y comentar mas
		

func end_turn() -> void:
	
	
	if turn == "blue":
			
		turn = "red"
			
	else:
		turn = "blue"
		
	for jugador in jugadores:
		jugador.reset_game_actions()
		jugador.update_player_labels()
	

# Called when the node enters the scene tree for the first time.
func _ready():
	
	pass
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	#end_turn()
	pass
