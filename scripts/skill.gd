extends Node2D
class_name ActiveSkill

@onready var skill_name_lbl = $skill_name_lbl
@export var mana_cost: int
@export var damage: int
@export var skill_name: String
@export var description: String
@export var actor: Piece
@export var initial_turn_cooldown: int
@export var on_cooldown: bool = false
var turn_cooldown: int
@onready var skill_button = $Control/skill_button
@onready var target_piece: Piece

#state vars
@onready var state_machine = $StateMachine as StateMachine
@onready var choose_target_state = $StateMachine/ChooseTargetState as ChooseTargetState
@onready var inactive_skill_state = $StateMachine/InactiveSkillState as InactiveSkillState
@onready var execute_skill_state = $StateMachine/ExecuteSkillState as ExecuteSkillState

#TODO
#el rango de las habilidades deberia funcionar similar a como funciona el del ataque basico
#quizas necesite tener una clasificacion extra de habilidades activas
#habilidad de daño fisico/magico melee
#habilidad de daño fisico/magico distancia
#buff/debuff
#otras (movimiento de piezas, invocacion de unidades, etc)

# Called when the node enters the scene tree for the first time.
func _ready():
	turn_cooldown = initial_turn_cooldown
	set_skill_name()
	inactive_skill_state.skill_activated.connect(state_machine.change_state.bind(choose_target_state))
	choose_target_state.skill_deactivated.connect(state_machine.change_state.bind(inactive_skill_state))
	choose_target_state.skill_executed.connect(state_machine.change_state.bind(execute_skill_state))
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	#directamente lo voy a acomodar desde aca en la esquina inferior izq con anchors
	#skill_button.global_position = UiManager.active_skill_panel.global_position
	deactivate_casting()
	set_button_pos()
	reset_cooldown()
	
	#hide_or_show_skill_button()

#el efecto que realiza la habilidad
func active_effect() -> void:
	pass

func show_label_when_cast() -> void:
	#should show label and make it go negative on y axis (go up) 
	#then set to be not visible again
	var end_position: Vector2 = skill_name_lbl.global_position + Vector2(0,-30)
	skill_name_lbl.visible = true
	var tween: Tween = get_tree().create_tween()				
	tween.tween_property(skill_name_lbl, "position", end_position, 0.5)
	await tween.finished
	#skill_name_lbl.visible = false

func set_skill_name() -> void:
	skill_name_lbl.text = skill_name

func set_button_pos() -> void:
	#por ahora uso este metodo para acomodar el boton donde quiero pero no creo que sirva 
	#en pantallas de otras resoluciones
	var screen_size = get_viewport().size
	skill_button.global_position = UiManager.active_skill_panel.position - Vector2(screen_size/6)#UiManager.active_skill_panel.position - Vector2(screen_size)#screen_size #Vector2(20, screen_size.y - 20)

func hide_or_show_skill_button() -> void:
	if actor:
		if actor.isCastingSkill:
			skill_button.visible = true
		else:
			skill_button.visible = false

func set_on_cooldown() -> void:
	on_cooldown = true
	skill_button.disabled = true
	turn_cooldown = initial_turn_cooldown
	skill_button.modulate = Color(128, 128, 128)
		
func reset_cooldown() -> void:
	#lo hago hasta -1 porque sino siempre tengo un turno menos de cooldown
	if turn_cooldown == -1 and on_cooldown:
		on_cooldown = false
		skill_button.disabled = false
		skill_button.modulate = Color(0.502, 0.502, 0.502, 1)

func deactivate_casting() -> void:
	if !actor.isActive:
		choose_target_state.emit_signal("skill_deactivated")
		
func _on_skill_button_pressed():
	inactive_skill_state.emit_signal("skill_activated")
