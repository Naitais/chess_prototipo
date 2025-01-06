extends Efecto

# Called when the node enters the scene tree for the first time.
func _ready():
	super._ready()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	super._process(delta)

func activate_effect() -> void:
	if !is_active:
		if actor.health < actor.max_health:
			modify_piece_stat("health")
			is_active = true
		else:
			print("no se puede agregar punto de vida si ya tiene el maximo")
			queue_free()
		#TODO creo que aca tendria que hacerle un queue free
