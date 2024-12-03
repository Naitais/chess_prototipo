extends Node2D
class_name Jugador
var turno_activo: bool
@export var team: String 
@onready var piezas = $piezas

var BISHOP = load("res://scenes/bishop.tscn").instantiate()
var CABALLERO = load("res://scenes/caballero.tscn").instantiate()
var KING = load("res://scenes/king.tscn").instantiate()
var QUEEN = load("res://scenes/queen.tscn").instantiate()
var ROOK = load("res://scenes/rook.tscn").instantiate()

# Called when the node enters the scene tree for the first time.
func _ready():
	set_team()
	arrange_pieces(team)
	
func set_team() -> void:
	for piece in piezas.get_children():
		piece.team = self.team

func arrange_pieces(team: String) -> void:
	var contador_knight: int = 0
	var contador_rook: int = 0
	var contador_bishop: int = 0
	var x: int = 0
	var y: int
	#seteo y para ordenar peones segun el equipo
	if team == "red":
		y = 1
	else:
		y = 6
		
	for piece in piezas.get_children():
		
		#ARRENGE PANWS
		if piece is Pawn:
			var posicion: Vector2 = Vector2(x,y)
			piece.global_position = posicion * 64
			x += 1
		#ARRENGE KINGS
		elif piece is King:
			if team == "red":
				piece.global_position = Vector2(4,0) * 64
			else:
				piece.global_position = Vector2(4,7) * 64
		
		#ARRENGE QUEENS
		elif piece is Queen:
			if team == "red":
				piece.global_position = Vector2(3,0) * 64
				
			else:
				piece.global_position = Vector2(3,7) * 64
				
		#ARRENGE KNIGHTS
		elif piece is Knight:
			if team == "red":
				if contador_knight == 0:
					piece.global_position = Vector2(1,0) * 64
					#cuando pongo el primer caballo sumo 1 para poner el siguiente
					#y no repetir este caballo que ya puse
					contador_knight +=1
				
				else:
					piece.global_position = Vector2(6,0) * 64
				
			#equipo azul
			elif team == "blue":
				if contador_knight == 0:
					piece.global_position = Vector2(1,7) * 64
					#cuando pongo el primer caballo sumo 1 para poner el siguiente
					#y no repetir este caballo que ya puse
					contador_knight +=1
				
				else:
					piece.global_position = Vector2(6,7) * 64
					
		#ARRENGE ROOKS
		elif piece is Rook:
			if team == "red":
				if contador_rook == 0:
					piece.global_position = Vector2(0,0) * 64
					#cuando pongo el primer caballo sumo 1 para poner el siguiente
					#y no repetir este caballo que ya puse
					contador_rook +=1
				
				else:
					piece.global_position = Vector2(7,0) * 64
				
			#equipo azul
			elif team == "blue":
				
				if contador_rook == 0:
					piece.global_position = Vector2(0,7) * 64
					#cuando pongo el primer caballo sumo 1 para poner el siguiente
					#y no repetir este caballo que ya puse
					contador_rook +=1
				
				else:
					piece.global_position = Vector2(7,7) * 64
					
		
		#ARRENGE BISHOPS
		elif piece is Bishop:
			if team == "red":
				if contador_bishop == 0:
					piece.global_position = Vector2(2,0) * 64
					#cuando pongo el primer caballo sumo 1 para poner el siguiente
					#y no repetir este caballo que ya puse
					contador_bishop +=1
				
				else:
					piece.global_position = Vector2(5,0) * 64
				
			#equipo azul
			elif team == "blue":
				
				if contador_bishop == 0:
					piece.global_position = Vector2(2,7) * 64
					#cuando pongo el primer caballo sumo 1 para poner el siguiente
					#y no repetir este caballo que ya puse
					contador_bishop +=1
				
				else:
					piece.global_position = Vector2(5,7) * 64
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
