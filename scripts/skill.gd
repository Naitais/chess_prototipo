extends Node2D
class_name ActiveSkill

@onready var skill_name_lbl = $skill_name_lbl
@export var mana_cost: int
@export var damage: int
@export var skill_name: String
@export var description: String
@export var actor: Pawn
@onready var skill_button = $Control/skill_button

@onready var target_piece: Piece
@onready var state_machine = $StateMachine as StateMachine
@onready var choose_target_state = $StateMachine/ChooseTargetState as ChooseTargetState
@onready var inactive_skill_state = $StateMachine/InactiveSkillState as InactiveSkillState

#TODO
#el rango de las habilidades deberia funcionar similar a como funciona el del ataque basico
#quizas necesite tener una clasificacion extra de habilidades activas
#habilidad de daño fisico/magico melee
#habilidad de daño fisico/magico distancia
#buff/debuff
#otras (movimiento de piezas, invocacion de unidades, etc)

# Called when the node enters the scene tree for the first time.
func _ready():
	set_button_pos()
	set_skill_name()
	inactive_skill_state.skill_activated.connect(state_machine.change_state.bind(choose_target_state))
	choose_target_state.skill_deactivated.connect(state_machine.change_state.bind(inactive_skill_state))

	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	#directamente lo voy a acomodar desde aca en la esquina inferior izq con anchors
	#skill_button.global_position = UiManager.active_skill_panel.global_position
	deactivate_casting()
	
func set_skill_name() -> void:
	skill_name_lbl.text = skill_name

func set_button_pos() -> void:
	#por ahora uso este metodo para acomodar el boton donde quiero pero no creo que sirva 
	#en pantallas de otras resoluciones
	var screen_size = get_viewport().size / 1.5
	skill_button.global_position = UiManager.active_skill_panel.position - Vector2(screen_size)#screen_size #Vector2(20, screen_size.y - 20)

func deactivate_casting() -> void:
	if !actor.isActive:
		choose_target_state.emit_signal("skill_deactivated")

func _on_skill_button_pressed():
	inactive_skill_state.emit_signal("skill_activated")
