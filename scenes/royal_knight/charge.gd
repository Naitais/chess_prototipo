extends ActiveSkill

# Called when the node enters the scene tree for the first time.
func _ready():
	super._ready()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	super._process(delta)

func start_move_tween(final_pos) -> void:
	var tween: Tween = get_tree().create_tween()				
	tween.tween_property(actor, "position", Vector2(Global.board.local_to_map(final_pos) * 64), 0.5)
	await tween.finished

func skill_action() -> void:
	start_move_tween(Global.target_piece.position)
	print(self)
	print(Global.board.local_to_map(actor.position))
	print(Global.board.local_to_map(Global.target_piece.position))
	
