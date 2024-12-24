extends Node2D
class_name Efecto

#un efecto es el resltado del accionar de una habilidad pasiva o activa
#puede ser hemorragia, congelamiento, inmolacion, veneno, noqueado (stun), fortificacion, etc

@export var duracion: int #duracion en turnos del efecto
@export var nombre: String
@export var descripcion: String
@export var stat_mod_num: int #monto por el cual se modifica una estadistica
@export var actor: Piece #pieza que es afectada por el efecto
@export var is_active: bool = false

#state machine
@onready var state_machine = $StateMachine as StateMachine
@onready var inactive_effect_state = $StateMachine/InactiveEffectState as InactiveEffectState
@onready var active_effect_state = $StateMachine/ActiveEffectState as ActiveEffectState


# Called when the node enters the scene tree for the first time.
func _ready():
	inactive_effect_state.effect_activated.connect(state_machine.change_state.bind(active_effect_state))

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	send_signal_on_actor_true()

#funcion que incrementa o decrece un stat
#recibe string para determinar el stat a modificar
#esta funcion la voy a utilizar en muchos efectos
func modify_piece_stat(stat_type: String) -> void:
	
	match stat_type:
		
		"health": actor.health += stat_mod_num
	
		"armor": actor.armor += stat_mod_num
		
		"physical_damage": actor.physical_damage += stat_mod_num
		
		"magic_shield": actor.magic_shield += stat_mod_num
		
		"magic_damage": actor.magic_damage += stat_mod_num
		
	actor.set_stats()

func send_signal_on_actor_true() -> void:
	if actor != null:
		inactive_effect_state.emit_signal("effect_activated")
