extends Piece
class_name Pawn
#cuando duplico las piezas se bugean tengo que ver como crearlas para no tener problemas 
#revisar si tiene que ver con algo de las state machines
#probar duplicar reinas o reyes para ver si ocurre lo mismo
func _ready():
	super._ready()
	
	#print(self)
