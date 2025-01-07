extends Node2D
class_name ActiveSkill


@export var mana_cost: int
@export var damage: int
@export var skill_name: String
@export var description: String
@export var actor: Piece
@export var objective_piece: Piece
@export var initial_turn_cooldown: int
@export var on_cooldown: bool = false
@export var effect_list: Array
@export var matrix_range: Vector2
#tipos de active skill para determinar como funcionan:
	#fisico_melee -> se activa desde el ReceiveDamageState de piece
	#buff_debuff_rango
	#fisico_rango
	#magico_rango
	#buff
	#debuff
@export var tipo: String

var _pieza: Piece
var pieces_in_range: Array
#var pos_pieces_in_range: Array
var turn_cooldown: int
var choosing_target: bool = false
@onready var target_piece: Piece
@onready var skill_description_lbl = $skill_description_lbl
@onready var skill_name_lbl = $skill_name_lbl
@onready var skill_button = $control_button/skill_button
@onready var cooldown_countdown_lbl = $control_button/cooldown_countdown_lbl

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

#TODO agregar que el area 2d del rango de la habilidad cree squares de la misma forma 
#que lo hace el movimiento de las piezas

# Called when the node enters the scene tree for the first time.
func _ready():
	turn_cooldown = initial_turn_cooldown
	set_labels_text()
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
	show_cooldown_countdown()
	#hide_or_show_skill_button()

#el efecto que realiza la habilidad
#esto deberia ser dependiendo del tipo de habilidad
#si es una habilidad que afecta solo al caster
#o si afecta solo al objetivo o si afecta a ambos con distintos efectos
#supongo que podria tener distintas versiones de este metodo
#y solo modificarla segun la habilidad

#salvation prayer ya se ejecuta ahora solo me queda pasar la pieza a este metodo cuando lo llamo
#en el execute skill state
func add_effect() -> void:
	for effect in effect_list:
		if _pieza:
			var effect_node: Efecto = StateEffectManager.get_effect(effect)
			effect_node.origen = self.skill_name #agrego el origen
			_pieza.efectos.add_child(effect_node.duplicate())
		else:
			var effect_node: Efecto = StateEffectManager.get_effect(effect)
			effect_node.origen = self.skill_name #agrego el origen
			actor.efectos.add_child(effect_node.duplicate())
	if _pieza:
		_pieza.set_stats()
	else:
		actor.set_stats()


func set_labels_text() -> void:
	skill_name_lbl.text = skill_name
	skill_description_lbl.text = description

func set_button_pos() -> void:
	#por ahora uso este metodo para acomodar el boton donde quiero pero no creo que sirva 
	#en pantallas de otras resoluciones
	var screen_size = get_viewport().size
	skill_button.global_position = UiManager.active_skill_panel.position - Vector2(screen_size/6)#UiManager.active_skill_panel.position - Vector2(screen_size)#screen_size #Vector2(20, screen_size.y - 20)
	#skill_button.position = UiManager.active_skill_panel.global_position
	
func show_cooldown_countdown() -> void:
	if on_cooldown:
		cooldown_countdown_lbl.visible = true
		var skill_cooldown_countdown: int = turn_cooldown
		cooldown_countdown_lbl.text = str(turn_cooldown)
		cooldown_countdown_lbl.global_position = skill_button.global_position
	else:
		cooldown_countdown_lbl.visible = false
	

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
	actor.isCastingSkill = false
	
func reset_cooldown() -> void:
	if turn_cooldown == 0 and on_cooldown:
		on_cooldown = false
		skill_button.disabled = false
		skill_button.modulate = Color(1, 1, 1, 1)

func deactivate_casting() -> void:
	if !actor.isActive:
		choose_target_state.emit_signal("skill_deactivated")


	


func _on_skill_button_pressed():
	inactive_skill_state.emit_signal("skill_activated")


func _on_skill_button_mouse_entered():
	skill_description_lbl.position = skill_button.position
	skill_description_lbl.visible = true


func _on_skill_button_mouse_exited():
	skill_description_lbl.visible = false


func _on_skill_area_body_entered(body):
	
	if body is Piece and body.team != actor.team:
		if body not in pieces_in_range:
			pieces_in_range.append(body)
			#print("El actor es: ",actor," posicion: ",Global.board.local_to_map(actor.global_position), " del equipo: ",actor.team," y detecto a: ", body, body.team, " en posicion ", Global.board.local_to_map(body.global_position))
			#print(pieces_in_range)
	#if body is Piece and body.team == actor.team:
		#if body not in pieces_in_range:
			#pieces_in_range.append(body)
			#actor.posiciones_de_skill_range.append(Vector2(Global.board.local_to_map(body.position)))
			

func _on_skill_area_body_exited(body):
	if body in pieces_in_range:
			pieces_in_range.erase(body)
			
