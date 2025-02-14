class_name ExecuteSkillState
extends State

@export var button: Button
@export var skill: ActiveSkill
@export var skill_name_lbl: Label

signal skill_executed

func _ready():
	#con esto hago que este desactivado el fisics prouces
	set_physics_process(false)

func show_skill_name_when_cast() -> void:
	#guardo pos inicial para setearla de nuevo al final
	var initial_pos: Vector2 = skill_name_lbl.position
	var end_pos: Vector2 = skill_name_lbl.position + Vector2(0,-50)
	
	skill_name_lbl.visible = true
	
	var tween: Tween = get_tree().create_tween()				
	tween.tween_property(skill_name_lbl, "position", end_pos, 1)
	await tween.finished
	
	skill_name_lbl.visible = false
	skill_name_lbl.position = initial_pos
	
	


func _enter_state() -> void:
	#skill.skill_action()
	#solo se activa cuando entro al state wander
	skill.actor.jugador.deplete_mana(skill.mana_cost)
	skill.add_effect()
	show_skill_name_when_cast()
	skill.set_on_cooldown()
	
	set_physics_process(true)


func _exit_state() -> void:
	#cuando se sale se pone false
	set_physics_process(false)
	
	
func _physics_process(_delta):
	pass
	
