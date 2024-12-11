extends Node2D
class_name Jugador

@export var team: String
@export var mana: int
@export var extra_mana: int
@export var max_mana: int
@export var gold: int
@onready var piezas = $piezas
@onready var mana_lbl = $mana_lbl
@onready var extra_mana_lbl = $extra_mana_lbl


#VARIABLES DE ACCIONES DEL TURNO si ambas vars son true, automaticamente se pasa el turno
#si ya se ataco o se movio no se puede vovler a hacer hasta el proximo turno
#var ataque_realizado: bool = false
#var pieza_movida: bool = false

# Called when the node enters the scene tree for the first time.
func _ready():
	TurnManager.jugadores.append(self)
	set_mana()
	set_team()
	arrange_pieces(team)
	set_label_pos()
	
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

func set_label_pos() -> void:
	mana_lbl.text = mana_lbl.text+str(mana)
	extra_mana_lbl.text = extra_mana_lbl.text+str(extra_mana)
	if self.team == "blue":
		mana_lbl.global_position = Vector2(525, 379)
		extra_mana_lbl.global_position = Vector2(525, 400)

func update_player_labels() -> void:
	mana_lbl.text = " "
	mana_lbl.text = "Mana: "+str(mana)
	
	extra_mana_lbl.text = " "
	extra_mana_lbl.text = "Extra mana: "+str(extra_mana)
	
#after each round mana is reset
func set_mana() -> void:
	
	mana = max_mana

func save_extra_mana() -> void:
	#if Global.turn != self.team:
	extra_mana += min(mana, 3 - extra_mana) #como maximo se puede guardar 3 de mana

#to reduce mana when an action is done
func deplete_mana(amount: int) -> void:
	if self.extra_mana > 0:
			# Subtract damage from armor first
		var mana_to_spend = min(amount, self.extra_mana)  # Only reduce armor by the amount it has
		self.extra_mana -= mana_to_spend
						
		# Calculate remaining mana to spend after extra mana
		var rest_mana_to_spend = amount - mana_to_spend
						
		self.mana -= rest_mana_to_spend
			
	else:
		# If no armor, apply all damage to health
		
		self.mana -= amount

#it can be used to deplete or increase gold
func modify_gold(amount: int) -> void:
	gold += amount

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
	#print("MI EQUIPO ES ", team)
	#print(ataque_realizado, " ataque")
	#print(pieza_movida, " movimiento")
