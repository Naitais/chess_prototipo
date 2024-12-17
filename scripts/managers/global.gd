extends Node


var selected_piece: Piece
var tilemap_positions: Array = []
var occupied_positions: Array = []
var pieces_on_board: Array = []
var board: TileMap = null
var game_end: bool = false
var king_check: bool = false

#TODO
#LOS ELEMENTOS DE LA ESCENA DE LA ACTIVE SKILL SON EL BUG PORQUE EL MOUSE NO DETECTA LA PIEZA QUE ESTA DEBAJO
#REVISAR BUG EL ERROR QUIZAS SEA LAS SKILLS ESTAN TAPANDO EL LADO DERECHO PRO ESO SOLO PASA EN ROYAL SOLDIER
#el peon rojo esta bugeado, le falta la posicion ofensiva del lado derecho
#TODO revisar el numero de countdown como deberia funcionar
#implementar tooltip

#implementar check del rey (el rey esta en check si esta al alcance de una pieza tanto en mov como en pos of)
#implementar enroque (castling)

#agregar un pequeño icono que identifique que clase de pieza es cada una, una para peon, rey, reina etc
#asi es facil identificar la clase de cada pieza. quizas esto puede estar en un tooltip con el nombre de la pieza
# cuando se hoverea o hace clic derecho, puede mostrar los estados que afectan a la pieza, los stats, la habilidad
#pasiva y la habilidad activa

# limpiar el codigo y comentar mas

# Called when the node enters the scene tree for the first time.
func _ready():
	
	pass

func esperar(segundos: float) -> void:
	await get_tree().create_timer(segundos).timeout

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
	
