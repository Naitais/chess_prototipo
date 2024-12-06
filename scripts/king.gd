extends Piece
class_name King

func _ready():
	super._ready()
	
	
func _physics_process(delta):
	super._physics_process(delta)
	#print(check_if_king_is_threatened())
	#if check_if_king_is_threatened():
	#	Global.king_check = true
	
func check_if_king_is_threatened() -> bool:
	#print(Global.board.local_to_map(self.global_position), self.name)
	var piece_pos: Vector2 = Global.board.local_to_map(self.global_position)
	if Global.selected_piece:
		if piece_pos in Global.selected_piece.posiciones_de_ataque:
			return true
		else:
			return false
	return false
