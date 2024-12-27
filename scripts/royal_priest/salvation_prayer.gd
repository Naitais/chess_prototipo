extends ActiveSkill


@onready var skill_collision_shape = $skillArea/CollisionShape2D


# Called when the node enters the scene tree for the first time.
func _ready():
	super._ready()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	super._process(delta)
	set_skill_area_pos()
	#set_pieces_in_range_when_casting()
	#print(actor.posiciones_de_ataque)
	
	
func set_skill_area_pos() -> void:
	skill_collision_shape.global_position = actor.position + Vector2(32,32)
		
