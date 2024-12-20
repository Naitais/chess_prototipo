extends Node

var states: Dictionary = {
	
	"Wall of Pawns": ""
	
}
# Called when the node enters the scene tree for the first time.

func increase_armor_effect(piece: Piece, ammount: int) -> void:
	
	piece.armor += ammount

func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
