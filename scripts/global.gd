extends Node


var selected_piece: Piece
var tilemap_positions: Array = []
var occupied_positions: Array = []
var pieces_on_board: Array = []
var board: TileMap = null
var turn: String = "blue" #siempre empieza el azul
var jugadores: Array
var turns_in_round: int = 0
var round_counter: int = 1
var game_end: bool = false
#TODO
# logica de turnos -> agregar temporizador y agregar contador de rondas y turnos
# limpiar el codigo y comentar mas

func end_turn() -> void:
	if turn == "blue":
		turn = "red"
	else:
		turn = "blue"

	# Increment the number of turns in this round
	turns_in_round += 1

	# Check if both players have completed their turns
	if turns_in_round >= 2:
		round_counter += 1 # Increment the round counter
		turns_in_round = 0 # Reset the turn counter for the next round
		print("Round:", round_counter)

	# Reset game actions and update labels for both players
	for jugador in jugadores:
		jugador.reset_game_actions()
		jugador.update_player_labels()
	

# Called when the node enters the scene tree for the first time.
func _ready():
	print("Round:", round_counter)
	pass
	
func check_game_end(team):
	turn = "termino el juego"
	if team == "red":
		print("Gana el equipo azul")
	
	else:
		print("Gana el equipo rojo")
	
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	#end_turn()
	pass
