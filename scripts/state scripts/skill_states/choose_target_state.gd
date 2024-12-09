class_name ChooseTargetState
extends State


@export var button: Button
@export var skill: ActiveSkill

signal skill_deactivated

func _ready():
	#con esto hago que este desactivado el fisics prouces
	set_physics_process(false)

#esto si funciona solo que la vez pasada lo configure mal
#tengo que activarlo cuando la pieza esta activa
#tendria que crear un export de la skill
#y a partir de ahi hacer skill.actor.isActive = true -> entonces muestro el boton
func show_button() -> void:
	button.visible = true

func _enter_state() -> void:
	#solo se activa cuando entro al state wander
	skill.actor.isCastingSkill = true
	set_physics_process(true)
	
func _exit_state() -> void:
	#cuando se sale se pone false
	set_physics_process(false)
	
func _physics_process(_delta):
	pass
	
