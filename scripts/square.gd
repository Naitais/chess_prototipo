extends Node2D
class_name Square

#utilizo los squares para mostrar el rango de las skills
@export var is_skill_square: bool

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta'         is the elapsed time since the previous frame.
func _process(delta):
	show_or_hide_square()
	change_colour()
	pos_is_inside_map(self.position)
	if !Global.selected_piece:
		queue_free()
	
func change_colour() -> void:
	if is_skill_square:
		
		self.modulate = Color(200, 0, 0)
		

func show_or_hide_square() -> void:
	if Global.selected_piece:
		if is_skill_square:
		
			if Global.selected_piece.isCastingSkill:
				self.visible = true
			else:
				self.visible = false
		
		if !is_skill_square and Global.selected_piece.isCastingSkill:
			queue_free()
		
		
#reviso si las ubicaciones para movimientos estan afuera o dentro del mapa
func pos_is_inside_map(position) -> void:
	var converted_pos: Vector2 = Global.board.local_to_map(global_position)
	if converted_pos not in Global.tilemap_positions:
		queue_free()
			

		
	

func _on_detect_piece_body_entered(body):
	if body is Piece and !is_skill_square:
		#check if already exists, if not add it
		if !(body.position in Global.occupied_positions):
			Global.occupied_positions.append(body.position)
		queue_free()
	
	
