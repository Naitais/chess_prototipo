extends ActiveSkill

func _ready():
	super._ready()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	super._process(delta)

func _on_skill_area_body_entered(body):
	if body is Piece:
		if body not in pieces_in_range:
			pieces_in_range.append(body)
			
			#print("El actor es: ",actor," posicion: ",Global.board.local_to_map(actor.global_position), " del equipo: ",actor.team," y detecto a: ", body, body.team, " en posicion ", Global.board.local_to_map(body.global_position))
			#print(pieces_in_range)
	#if body is Piece and body.team == actor.team:
		#if body not in pieces_in_range:
			#pieces_in_range.append(body)
			#actor.posiciones_de_skill_range.append(Vector2(Global.board.local_to_map(body.position)))
			

func _on_skill_area_body_exited(body):
	if body in pieces_in_range:
			pieces_in_range.erase(body)
