extends Node


var selected_piece: Piece
var tilemap_positions: Array = []
var occupied_positions: Array = []
var pieces_on_board: Array = []
var board: TileMap = null
var game_end: bool = false
var king_check: bool = false

#TODO
#implementar tooltip

#implementar check del rey (el rey esta en check si esta al alcance de una pieza tanto en mov como en pos of)
#implementar enroque (castling)

#tengo que terminar de pensar como voy a trabajar lo de los states

#nuevo planteamiento -> tanto las habilidades activas como pasivas desencadenan efectos
#los efectos van a ser nodos que se agregan a un nodo contenedor de efectos llamado efectos
#cada efecto va a tener su state machine con sus metodos y atributos
#cada pieza deberia tener un metodo que recorra los efectos que tiene cargados y en base a eso accionarlo
#cuando muestre la barra de efectos y habilidades pasivas activas,
#primero se muestran en una row las habilidades pasivas y en una row debajo los efectos activos en la pieza
#si se hoverea la habilidad pasiva, en la descripcion va a estar subrayado o enfatizado el efecto
#y cuando se hoveree el efecto va a mostrar en rojo o verde (dependiendo si es algo bueno o malo),
#de donde proviene ese efecto, si es de una habilidad activa que afecto a la pieza o si viene de una habilidad
#pasiva de la misma pieza u otra que la afecto esto va a estar conn un asterisco debajo de la descripcion
#de la habilidad pasiva

#cada pieza debe tener un array llamado states
#al inicio de cada turno cada pieza debe correr un metodo que revise que states
#se encuentran actualmente en el array states y dependiendo de eso
#se activa el efecto del state mientras exista en el array states de la pieza
#y de esa manera manejo los estados que afectan a cada pieza
#esto sirve para ahorrar codigo ya que muchos estados pueden repetirse
#en distintas skills ya sean pasivas o activas
#cuando se implemente el metodo que aplique los estados tambien debe llamar al metodo que 
#actualiza los labels asi se refleja automaticamente en las estadisticas de la pieza

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
	
