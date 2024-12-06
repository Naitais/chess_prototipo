extends Node2D
class_name ActiveSkill

@onready var skill_name_lbl = $skill_name_lbl
@export var mana_cost: int
@export var damage: int
@export var skill_name: String
@export var description: String
@export var actor: Pawn

@onready var state_machine = $StateMachine as StateMachine
@onready var choose_target_state = $StateMachine/ChooseTargetState as ChooseTargetState
@onready var inactive_skill_state = $StateMachine/InactiveSkillState as InactiveSkillState

# Called when the node enters the scene tree for the first time.
func _ready():
	set_skill_name()
	inactive_skill_state.skill_activated.connect(state_machine.change_state.bind(choose_target_state))
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func set_skill_name() -> void:
	skill_name_lbl.text = skill_name

func _on_skill_button_pressed():
	inactive_skill_state.emit_signal("skill_activated")
