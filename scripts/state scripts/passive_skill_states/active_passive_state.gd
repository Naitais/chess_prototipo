class_name ActivePassiveState
extends State

@export var skill: PassiveSkill

signal passive_deactivated


func _ready():
	#con esto hago que este desactivado el fisics prouces
	set_physics_process(false)

func _enter_state() -> void:
	
	
	#solo se activa cuando entro al state wander
	set_physics_process(true)
	
func _exit_state() -> void:
	#cuando se sale se pone false
	set_physics_process(false)
	
func _physics_process(_delta):
	set_effect_on_near_pawns()
	print("swag")
	
func set_effect_on_near_pawns() -> void:
	if not skill.passive_activated:
		
		for piece in skill.ally_near_pawns:
			skill.add_effect(piece)
			
		
		skill.passive_activated = true
		#aca emito la señal para parar
		emit_signal("passive_deactivated")
		
