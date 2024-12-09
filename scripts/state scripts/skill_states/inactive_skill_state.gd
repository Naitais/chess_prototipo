class_name InactiveSkillState
extends State

@export var button: Button
@export var skill: ActiveSkill

signal skill_activated

func _ready():
	#con esto hago que este desactivado el fisics prouces
	set_physics_process(false)

func hide_button() -> void:
	button.visible = false

func _enter_state() -> void:
	#solo se activa cuando entro al state wander
	skill.actor.isCastingSkill = false
	set_physics_process(true)
	
func _exit_state() -> void:
	#cuando se sale se pone false
	set_physics_process(false)
	
func _physics_process(_delta):
	#hide_button()
	pass
