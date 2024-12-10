extends Node


var selected_piece: Piece
var tilemap_positions: Array = []
var occupied_positions: Array = []
var pieces_on_board: Array = []
var board: TileMap = null
var game_end: bool = false
var king_check: bool = false

#TODO
# logica de turnos -> agregar temporizador

#implementar habilidades de royal soldier/por el momento cuando se usa una habilidad, en lugar
#de mostrar una animacion puedo mostrar un label indicando el nombre de la habilidad que se uso

#implementar tooltip

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

# Called when the node enters the scene tree for the first time.
func _ready():
	
	pass
	
func check_game_end(team):
	TurnManager.turn = "termino el juego"
	if team == "red":
		print("Gana el equipo azul")
	
	else:
		print("Gana el equipo rojo")

func exit() -> void:
	if Input.is_action_just_pressed("escape"):
		get_tree().quit()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	exit()
	
