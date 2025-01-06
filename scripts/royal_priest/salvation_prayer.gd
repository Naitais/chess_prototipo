extends ActiveSkill


@onready var skill_collision_shape = $skillArea/CollisionShape2D


# Called when the node enters the scene tree for the first time.
func _ready():
	super._ready()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	super._process(delta)
	#set_skill_area_pos()
	#set_pieces_in_range_when_casting()
	#print(actor.posiciones_de_ataque)
	


func set_skill_area_pos() -> void:
	skill_collision_shape.global_position = actor.position + Vector2(32,32)
		

func _on_skill_area_body_entered(body):
	if body is Piece and body.team == actor.team:
		if body not in pieces_in_range:
			#print("El actor es: ",actor," posicion: ",Global.board.local_to_map(actor.global_position), " del equipo: ",actor.team," y detecto a: ", body, body.team, " en posicion ", Global.board.local_to_map(body.global_position))
			#print(pieces_in_range)
			pieces_in_range.append(body)
