extends Node


var killed_piece: Piece
#var target_piece: Piece #hovered piece
var selected_piece: Piece
var selected_target_piece: Piece
var tilemap_positions: Array = []
var occupied_positions: Array = []
var pieces_on_board: Array = []
var board: TileMap = null
var turn: String = "blue" #siempre empieza el azul


#TODO
# logica de turnos
# limpiar el codigo y comentar mas


# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	#print(selected_target_piece)
	#print(board)
	pass
