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
