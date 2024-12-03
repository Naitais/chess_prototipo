extends Node2D
class_name Square


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_detect_piece_body_entered(body):
	if body is Piece:
		#check if already exists, if not add it
		if !(body.position in Global.occupied_positions):
			Global.occupied_positions.append(body.position)
		queue_free()
		
