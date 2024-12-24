class_name ActiveEffectState
extends State

@export var efecto: Efecto

signal effect_deactivated

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
	activate_effect()

func activate_effect() -> void:
	if !efecto.is_active:
		efecto.modify_piece_stat("armor")
		efecto.is_active = true
		
