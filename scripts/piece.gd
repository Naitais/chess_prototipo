extends CharacterBody2D
class_name Piece

@export var isActive: bool = false
@export var isKilled: bool = false
@export var initial_pos: Vector2
@export var final_pos: Vector2
@export var movement: int
@export var team: String

#TODO ESTADISTICAS
@export var physical_damage: int
@export var magic_damage: int
@export var health: int
@export var armor: int
@export var magic_shield: int

@onready var health_lbl = $health_lbl
@onready var physical_dmg_lbl = $physical_dmg_lbl
@onready var magical_dmg_lbl = $magical_dmg_lbl
@onready var armor_lbl = $armor_lbl
@onready var magical_shield_lbl = $magical_shield_lbl


@onready var sprite = $Sprite2D
@onready var mouse_pos: Vector2
@onready var jugador: Node2D

var square_positions: Array



#state machine vars
@onready var state_machine = $StateMachine as StateMachine
@onready var select_piece_state = $StateMachine/SelectPieceState as SelectPieceState
@onready var inactive_piece_state = $StateMachine/InactivePieceState as InactivePieceState
@onready var move_piece_state = $StateMachine/MovePieceState as MovePieceState


func _ready():
	
	inactive_piece_state.piece_hovered.connect(state_machine.change_state.bind(select_piece_state))
	select_piece_state.piece_not_hovered.connect(state_machine.change_state.bind(inactive_piece_state))
	select_piece_state.piece_is_selected.connect(state_machine.change_state.bind(move_piece_state))
	move_piece_state.piece_is_inactive.connect(state_machine.change_state.bind(inactive_piece_state))
	
func _physics_process(delta):
	
	#send_to_cemetery()
	#check_if_active_piece()
	deselect_piece()
	set_opaque_sprite()
	set_piece_colour()
	mouse_pos = get_global_mouse_position()
	set_stats()
	
	
func _on_piece_area_mouse_entered():
	
	#si hovereo a una pieza y esta inactivo entonces la marco como una pieza que va a ser matada
	#si el estado es seleccionar pieza no pasa nada
	#si el estado es mover entonces la pieza muere
	if isActive == false:
		#guardo la pieza que estoy hovereando
		Global.target_piece = self
		inactive_piece_state.emit_signal("piece_hovered")
		
func _on_piece_area_mouse_exited():
	
	#solo envio señal cuando la pieza esta inactiva sino cuando
	#salgo del area de la pieza me saca del move state 
	if !isActive:
		select_piece_state.emit_signal("piece_not_hovered")
		
		#seteo null cuando ya no estoy hovereando a la misma pieza
		if Global.target_piece == self:
			Global.target_piece = null

func set_opaque_sprite() -> void:
	#solo es opaca cuando esta inactiva
	if !isActive:
		
		sprite.self_modulate = Color(1,1,1,0.6)
		
			
func send_to_cemetery() -> void:
	if isKilled:
		self.global_position = Vector2(0,0)

func deselect_piece() -> void:
	#desactivo la pieza seleccionada con clic derecho
	if Input.is_action_just_pressed("right_click"):
		Global.selected_piece = null
		isActive = false
		sprite.self_modulate = Color(1,1,1)
		move_piece_state.emit_signal("piece_is_inactive")

func set_piece_colour() -> void:
	if team == "blue":
		sprite.modulate = Color8(0,126,255)
		pass
	else:
		sprite.modulate = Color8(255,0,50)
		pass
		
func set_stats() -> void:
	
	
	health_lbl.text = str(health)
	physical_dmg_lbl.text = str(physical_damage)
	armor_lbl.text = str(armor)
	magical_dmg_lbl.text = str(magic_damage)
	magical_shield_lbl.text = str(magic_shield)
	
