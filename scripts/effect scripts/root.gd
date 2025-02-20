extends Efecto
@onready var round_value: int
#para saber cuando tengo que hacerle queue free a un efecto de duracion
#tendria que tomar el numero de turno o ronda actual y sumarlo a la duracion
#el resultado seria la ronda o turno futuro en el cual deberia desaparecer dicho efecto

# Called when the node enters the scene tree for the first time.
func _ready():
	super._ready()
	set_round_value()

	# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	super._process(delta)
	check_round_cooldown()

func set_round_value() -> void:
	round_value = TurnManager.round_counter

func set_movement() -> void:

	if actor:
		
		if actor is Rook or actor is Queen or actor is Bishop or actor is Knight:
			actor.movement = 10
		if actor is Pawn or actor is King:
			
			actor.movement = 1
		

func check_round_cooldown() -> bool:
	if round_value+duracion == TurnManager.round_counter:
		set_movement()
		queue_free()
		return true
	else:
		return false

func activate_effect() -> void:
	#print(actor_movement)
	if actor:
		actor.movement = 0
	#guardo el movimiento de la pieza
	
	
