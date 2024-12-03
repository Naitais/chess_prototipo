extends Button
@onready var turno_label = $"../turno"


# Called when the node enters the scene tree for the first time.
func _ready():
	turno_label.text = "turno actual: "+Global.turn


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_pressed():
	if Global.turn == "blue":
		Global.turn = "red"
	else:
		Global.turn = "blue"
		
	turno_label.text = "turno actual: "+Global.turn
