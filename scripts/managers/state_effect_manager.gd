extends Node

# cuando llame para crear instancia debe ser asi: var efecto = load("res://scenes/square.tscn").instantiate()

var effects: Dictionary = {
	
	"shield": load("res://scenes/effects/shield.tscn").instantiate(),
	"heal": load("res://scenes/effects/heal.tscn").instantiate(),
	"root": load("res://scenes/effects/root.tscn").instantiate()
	
}
# Called when the node enters the scene tree for the first time.

#func increase_armor_effect(piece: Piece, ammount: int) -> void:	
#	piece.armor += ammount

func get_effect(effect_name: String) -> Efecto:
	var efecto: Efecto = effects.get(effect_name)
	return efecto

func _ready():
	#print(get_effect("Shield"))
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
