extends Node2D
class_name PassiveSkill

@export var skill_name: String
@export var description: String
@export var actor: Piece
@export var initial_turn_cooldown: int
@export var on_cooldown: bool = false

func set_state_on_piece(piece: Piece) -> void:
	if self.skill_name not in piece.states:
		piece.states.append(self.skill_name)
		#piece.armor += 1  # Add armor
		#piece.set_stats()  # Update stats if needed

func remove_state_from_piece(piece: Piece) -> void:
	if self.skill_name in piece.states:
		piece.states.erase(self.skill_name)
		piece.armor -= 1  # Add armor
		piece.set_stats()  # Update stats if needed

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
