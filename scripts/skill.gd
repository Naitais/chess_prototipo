extends Node2D
class_name ActiveSkill

@onready var skill_name_lbl = $skill_name_lbl
@export var mana_cost: int
@export var damage: int
@export var skill_name: String
@export var description: String
@export var actor: Pawn
@onready var skill_button = $Control/skill_button

@onready var state_machine = $StateMachine as StateMachine
@onready var choose_target_state = $StateMachine/ChooseTargetState as ChooseTargetState
@onready var inactive_skill_state = $StateMachine/InactiveSkillState as InactiveSkillState

# Called when the node enters the scene tree for the first time.
func _ready():
	set_button_pos()
	set_skill_name()
	inactive_skill_state.skill_activated.connect(state_machine.change_state.bind(choose_target_state))
	

	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	#directamente lo voy a acomodar desde aca en la esquina inferior izq con anchors
	#skill_button.global_position = UiManager.active_skill_panel.global_position
	pass
func set_skill_name() -> void:
	skill_name_lbl.text = skill_name

func set_button_pos() -> void:
	#por ahora uso este metodo para acomodar el boton donde quiero pero no creo que sirva 
	#en pantallas de otras resoluciones
	var screen_size = get_viewport().size / 1.5
	skill_button.global_position = UiManager.active_skill_panel.position - Vector2(screen_size)#screen_size #Vector2(20, screen_size.y - 20)

func _on_skill_button_pressed():
	inactive_skill_state.emit_signal("skill_activated")
