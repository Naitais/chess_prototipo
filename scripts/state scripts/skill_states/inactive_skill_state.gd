class_name InactiveSkillState
extends State

@export var button: Button
@export var skill: ActiveSkill
@export var button_control: Control

signal skill_activated

func _ready():
	#con esto hago que este desactivado el fisics prouces
	set_physics_process(false)

func hide_button() -> void:
	if skill.actor != Global.selected_piece:
		button.visible = false
		skill.visible = false
		button_control.visible = false

func show_button() -> void:
	if skill.actor.isActive:
		button_control.visible = true
		button.visible = true
		skill.visible = true

func _enter_state() -> void:
	hide_button()
	#solo se activa cuando entro al state wander
	
	#skill.actor.deselect_piece_no_click()
	skill.actor.isCastingSkill = false
	set_physics_process(true)
	
func _exit_state() -> void:
	#cuando se sale se pone false
	set_physics_process(false)
	
func _physics_process(_delta):
	show_button()
	pass
