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
var king_check: bool = false

#TODO
# logica de turnos -> agregar temporizador
#ARREGLAR BUG DE MOVIMIENTO DESPUES DE MATAR, HAY QUE AGREGAR EL CHECKEO DE QUE SOLO MUEVA
#SI MATAMOS A LA PIEZA Y TAMBIEN REVISAR EL METODO QUE SE ACTIVA AL MOVERSE PORQUE
#ESTA HACIENDO QUE SE PUEDA ATACAR INFINITAMENTE

#implementar habilidades de royal soldier/por el momento cuando se usa una habilidad, en lugar
#de mostrar una animacion puedo mostrar un label indicando el nombre de la habilidad que se uso

#implementar tooltip

#implementar logica de uso de mana

#implementar conteo de rondas o turnos para que afecte cuanto duran las habilidades como buffs/debuffs

#implementar check del rey (el rey esta en check si esta al alcance de una pieza tanto en mov como en pos of)
#implementar enroque (castling)
#
#reemplazar tags de acciones del jugador por iconos, cuando la accion esta disponible el icono esta a color
#cuando la accion esta en gris es porque esa accion ya fue realizada

#agregar un pequeño icono que identifique que clase de pieza es cada una, una para peon, rey, reina etc
#asi es facil identificar la clase de cada pieza. quizas esto puede estar en un tooltip con el nombre de la pieza
# cuando se hoverea o hace clic derecho, puede mostrar los estados que afectan a la pieza, los stats, la habilidad
#pasiva y la habilidad activa

# limpiar el codigo y comentar mas

func end_turn() -> void:
	if Global.selected_piece:
		Global.selected_piece.deselect_piece_no_click()
	
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
		
		if jugador.team == turn:
			jugador.set_mana()
			jugador.update_player_labels()
			
		if jugador.team != turn:
			jugador.save_extra_mana()

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
