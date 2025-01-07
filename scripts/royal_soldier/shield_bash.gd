extends ActiveSkill
@onready var collision_shape_2d = $skillArea/CollisionShape2D


# Called when the node enters the scene tree for the first time.
func _ready():
	super._ready()
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	super._process(delta)
	set_col_shape_pos()
func set_col_shape_pos() -> void:
	if actor.team == "red" and collision_shape_2d.position.y != 99:
		collision_shape_2d.position.y = 99
	
	
#func _on_skill_area_body_entered(body):
#	if body is Piece:
#		print(body)
		#if body not in pieces_in_range:
		#	pieces_in_range.append(body)
		#	actor.posiciones_de_skill_range.append(Vector2(Global.board.local_to_map(body.position)))
