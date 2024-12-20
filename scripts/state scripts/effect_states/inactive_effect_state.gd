class_name InactiveEffectState
extends State

@export var efecto: Efecto

signal effect_activated

func _ready():
	#con esto hago que este desactivado el fisics prouces
	set_physics_process(false)

func _enter_state() -> void:
	pass
	#solo se activa cuando entro al state wander
	
	#skill.actor.deselect_piece_no_click()
	
	set_physics_process(true)
	
func _exit_state() -> void:
	#cuando se sale se pone false
	set_physics_process(false)
	
func _physics_process(_delta):
	
	pass
