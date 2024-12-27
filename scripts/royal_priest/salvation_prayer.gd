extends ActiveSkill


@onready var skill_collision_shape = $skillArea/CollisionShape2D
var pieces_in_range: Array

# Called when the node enters the scene tree for the first time.
func _ready():
	super._ready()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	super._process(delta)
	set_skill_area_pos()
	

func set_skill_area_pos() -> void:
	skill_collision_shape.global_position = actor.position + Vector2(32,32)


func _on_skill_area_body_entered(body):
	
	if body is Piece and body.team == actor.team:
		if body not in pieces_in_range:
			pieces_in_range.append(body)


func _on_skill_area_body_exited(body):
	if body in pieces_in_range:
			pieces_in_range.erase(body)
