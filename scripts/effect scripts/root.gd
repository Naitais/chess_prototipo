extends Efecto
var actor_movement: int 
#para saber cuando tengo que hacerle queue free a un efecto de duracion
#tendria que tomar el numero de turno o ronda actual y sumarlo a la duracion
#el resultado seria la ronda o turno futuro en el cual deberia desaparecer dicho efecto

# Called when the node enters the scene tree for the first time.
func _ready():
	super._ready()
	

	# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	super._process(delta)

func activate_effect() -> void:
	actor_movement = actor.movement
	check_round_cooldown()
	if actor:
		actor.movement = 0
	
	
