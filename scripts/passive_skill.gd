extends Node2D
class_name PassiveSkill

@export var skill_name: String
@export var description: String
@export var actor: Piece
@export var initial_turn_cooldown: int
@export var on_cooldown: bool = false

@export var effect_list: Array

func add_effect() -> void:
	for effect in effect_list:
		var effect_node: Efecto = StateEffectManager.get_effect(effect)
		
		actor.efectos.add_child(effect_node.duplicate())

	actor.set_stats()

func set_effect_on_piece(piece: Piece) -> void:
	if self.skill_name not in piece.effects:
		piece.effects.append(self.skill_name)
		#piece.armor += 1  # Add armor
		#piece.set_stats()  # Update stats if needed

func remove_state_from_piece(piece: Piece) -> void:
	if self.skill_name in piece.effects:
		piece.effects.erase(self.skill_name)
		piece.armor -= 1  # Add armor
		piece.set_stats()  # Update stats if needed

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
