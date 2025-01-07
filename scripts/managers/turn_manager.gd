extends Node

var turn: String = "blue" #siempre empieza el azul
var jugadores: Array
var turns_in_round: int = 0
var round_counter: int = 1

# Called when the node enters the scene tree for the first time.
func _ready():
	print("Round:", round_counter)
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func end_turn() -> void:
	if Global.selected_piece:
		Global.selected_piece.deselect_piece_no_click()
	
	if turn == "blue":
		turn = "red"
	else:
		turn = "blue"
	
	for jugador in jugadores:
		
		if jugador.team == turn:
			jugador.set_mana()
			jugador.update_player_labels()
			
			#probar poner condicion aca para que haga lo del mana solo si es el final de la ronda
			cooling_down_skills(jugador)
			
		if jugador.team != turn:
			
			jugador.save_extra_mana()
	
	# Increment the number of turns in this round
	turns_in_round += 1
	
	# Check if both players have completed their turns
	if turns_in_round >= 2:
		round_counter += 1 # Increment the round counter
		turns_in_round = 0 # Reset the turn counter for the next round
		
		#for piece in Global.pieces_on_board:
		#	print(Global.board.local_to_map(piece.global_position))
		print("Round:", round_counter)

	# Reset game actions and update labels for both players
	

func cooling_down_skills(jugador: Jugador) -> void:
	
	var pieces: Array = jugador.piezas.get_children()
	
	for piece in pieces:
		if piece.active_skill and piece.active_skill.on_cooldown:
			if piece.active_skill.turn_cooldown > 0:
				piece.active_skill.turn_cooldown -= 1
				
			
			
