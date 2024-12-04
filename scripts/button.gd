extends Button
@onready var turno_label = $"../turno"


# Called when the node enters the scene tree for the first time.
func _ready():
	#turno_label.text = "turno actual: "+Global.turn
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	turno_label.text = "turno actual: "+Global.turn


func _on_pressed():
	Global.end_turn()
		
	#turno_label.text = "turno actual: "+Global.turn
