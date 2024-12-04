extends CharacterBody2D
class_name Piece

@export var isActive: bool = false
@export var isKilled: bool = false
@export var initial_pos: Vector2
@export var final_pos: Vector2
@export var movement: int
@export var team: String

#ESTADISTICAS
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
var posiciones_de_ataque: Array #posiciones que tiene la pieza para atacar segun su posicion actual
								#rey, reina y caballo tienen la misma logica

#state machine vars
@onready var state_machine = $StateMachine as StateMachine
@onready var select_piece_state = $StateMachine/SelectPieceState as SelectPieceState
@onready var inactive_piece_state = $StateMachine/InactivePieceState as InactivePieceState
@onready var move_piece_state = $StateMachine/MovePieceState as MovePieceState
@onready var receive_damage_state = $StateMachine/ReceiveDamageState as ReceiveDamageState


func _ready():
	
	inactive_piece_state.piece_hovered.connect(state_machine.change_state.bind(select_piece_state))
	inactive_piece_state.piece_is_target.connect(state_machine.change_state.bind(receive_damage_state))
	receive_damage_state.piece_not_hovered.connect(state_machine.change_state.bind(inactive_piece_state))
	select_piece_state.piece_not_hovered.connect(state_machine.change_state.bind(inactive_piece_state))
	select_piece_state.piece_is_selected.connect(state_machine.change_state.bind(move_piece_state))
	move_piece_state.piece_is_inactive.connect(state_machine.change_state.bind(inactive_piece_state))
	set_stats()
	
	
func _physics_process(delta):
	
	#send_to_cemetery()
	#check_if_active_piece()
	deselect_piece()
	set_opaque_sprite()
	set_piece_colour()
	mouse_pos = get_global_mouse_position()
	kill_piece()
	highlight_threatened_piece()
	
	
func _on_piece_area_mouse_entered():
	
	#hovereo la pieza que quiero seleccionar para mover
	if isActive == false:
		#activo la señal para seleccionar la pieza si es que hago click
		inactive_piece_state.emit_signal("piece_hovered")
		
	#si la pieza seleccionada para moverse ya existe, 
	#entonces es porque estoy buscando un objetivo para atacar
	if isActive == false and Global.selected_piece and team != Global.selected_piece.team:
		inactive_piece_state.emit_signal("piece_is_target")
		
func _on_piece_area_mouse_exited():
	#solo envio señal cuando la pieza esta inactiva sino cuando
	#salgo del area de la pieza me saca del move state 
	if !isActive:
		select_piece_state.emit_signal("piece_not_hovered")
		receive_damage_state.emit_signal("piece_not_hovered")
	

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
		posiciones_de_ataque.clear()
		isActive = false
		sprite.self_modulate = Color(1,1,1)
		move_piece_state.emit_signal("piece_is_inactive")

func set_piece_colour() -> void:
	if team == "blue":
		sprite.modulate = Color8(0,126,255)
		
	else:
		sprite.modulate = Color8(255,0,50)
		
func highlight_threatened_piece() -> void:
	if Global.selected_piece:
		if Global.selected_piece.team != self.team:
			for posicion in Global.selected_piece.posiciones_de_ataque:
				if posicion == Vector2(Global.board.local_to_map(self.global_position)):
					sprite.modulate = Color8(255,100,170)

#armar un nodo que tenga todo contenido lo de estadisticas
# hacer un sprite separado para cada estadistica asi
# cuando vale 0 desaparace tambien el sprite porque
#como funciona ahora queda el circulo de la estadistica colgado
func _update_stat_label(label: Label, value: int) -> void:
	label.visible = value > 0  # Show label only if value > 0
	if value > 0:
		label.text = str(value)  # Update text only when label is visible

func set_stats() -> void:
	_update_stat_label(health_lbl, health)
	_update_stat_label(physical_dmg_lbl, physical_damage)
	_update_stat_label(armor_lbl, armor)
	_update_stat_label(magical_dmg_lbl, magic_damage)
	_update_stat_label(magical_shield_lbl, magic_shield)

func kill_piece() -> void:
	if health <= 0:
		self.queue_free()
