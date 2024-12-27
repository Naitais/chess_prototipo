class_name InactivePassiveState
extends State

@export var skill: PassiveSkill

signal passive_activated

func _ready():
	#con esto hago que este desactivado el fisics prouces
	set_physics_process(false)

func _enter_state() -> void:
	set_physics_process(true)
	
func _exit_state() -> void:
	#cuando se sale se pone false
	set_physics_process(false)
	
func _physics_process(_delta):
	#lo pongo en falso de nuevo
	skill.passive_activated = false
