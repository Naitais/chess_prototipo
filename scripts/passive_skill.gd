extends Node2D
class_name PassiveSkill

@export var skill_name: String
@export var description: String
@export var actor: Piece
@export var initial_turn_cooldown: int
@export var on_cooldown: bool = false
@export var effect_list: Array

#state machine
@onready var state_machine = $StateMachine as StateMachine
@onready var inactive_passive_state = $StateMachine/InactivePassiveState as InactivePassiveState
@onready var active_passive_state = $StateMachine/ActivePassiveState as ActivePassiveState
@onready var delete_passive_state = $StateMachine/DeletePassiveState as DeletePassiveState

# Called when the node enters the scene tree for the first time.
func _ready():
	inactive_passive_state.passive_activated.connect(state_machine.change_state.bind(active_passive_state))
	active_passive_state.passive_deactivated.connect(state_machine.change_state.bind(inactive_passive_state))
	#delete_passive_state.effect_deleted.connect(state_machine.change_state.bind(inactive_passive_state))
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func add_effect(piece: Piece) -> void:
	for effect in effect_list:
		var effect_node: Efecto = StateEffectManager.get_effect(effect)
		effect_node.origen = self.skill_name #agrego el origen
		piece.efectos.add_child(effect_node.duplicate())

	piece.set_stats()
