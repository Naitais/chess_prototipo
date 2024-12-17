extends TileMap

@export var tilemap: TileMap
@onready var board = self

var map_size = Vector2(8, 8)
var mouse_inside_board_area: bool
var tile_dict: Dictionary = {}
var pieces_set: bool = false

func _ready():
	Global.board = self
	# Initialize the tile dictionary
	initialize_tile_dict()
	
func _physics_process(delta):
	#update_map_dictionary()
	#highlight_occupied_tiles()
	
	#set_pieces_on_board()
	pass
	
func initialize_tile_dict() -> void:
	for x in range(map_size.x):
		for y in range(map_size.y):
			var tile_pos: Vector2 = Vector2(x, y)
			#for piece in Global.pieces_on_board:
			#	var piece_pos: Vector2 = local_to_map(piece.global_position)
				#add_child(square_instance)
				#square_instance.position = (tile_pos * 64) + Vector2(32,32)
				#tile_dict[piece] = piece_pos # Initialize with no piece
			Global.tilemap_positions.append(tile_pos)
	#print(tile_dict)
			
#funcion para ordenar piezas
func set_pieces_on_board() -> void:
	
	var i: int = 0
	var g: int = 0
	
	#reemplazar este codigo por uno que recorra los children que sean clase jugador
	#y que tome cada pieza en el nodo piezas de cada jugador
	#y utilizando lo que recorre cada posicion, que le setee esa posicion a cada pieza
	#o lo puedo hacer manual igual
	
	if !pieces_set:
		for piece in Global.pieces_on_board:
			
			if piece is Pawn and piece.team == "blue":
				piece.global_position = (Vector2(i,6)) * 64
				i+=1
			elif piece is Pawn and piece.team == "red":
				
				piece.global_position = (Vector2(g,1)) * 64
				g+=1
				
			elif piece is Rook:
				if piece.team=="red":
					var contador: int = 0
					piece.global_position = (Vector2(contador,0))
					contador = 6
			
			#	r+=1
			#else:
				
			#	piece.global_position = (Vector2(y,1)) * 64
			#	y+=1
			
			pieces_set = true
	


		
#func update_map_dictionary() -> void:
#	for piece in pieces_on_board:
#		tile_dict[local_to_map(piece.global_position)] = piece
		#print(local_to_map(piece.global_position))

#func highlight_occupied_tiles() -> void:
#	for tile_pos in tile_dict.keys():
#		if tile_dict[tile_pos] == null:
#			print("Tile at position ", tile_pos, " is unoccupied.")


		
	#print(Global.occupied_positions)
	

#funciones de area para solo mover piezas cuando el mouse esta dentro del tablero
func _on_board_area_mouse_entered():
	mouse_inside_board_area = true

func _on_board_area_mouse_exited():
	mouse_inside_board_area = false

func _on_board_area_body_entered(body):
	if body is Piece and body not in Global.pieces_on_board:
		Global.pieces_on_board.append(body)

func _on_board_area_body_exited(body):
	if body is Piece:
		Global.pieces_on_board.erase(body)
	
	
