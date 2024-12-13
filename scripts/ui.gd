extends CanvasLayer
#el anchor point me sirve para acomodar objetos de control para la ui que funcionen con el aspect
#ratio de la pantalla en lugar de simplemente acomodarlos donde quiera
#de esta forma se acomodan segun la resolucion

@onready var active_skill_panel = $active_skill_panel

# Called when the node enters the scene tree for the first time.
func _ready():
	UiManager.active_skill_panel = active_skill_panel
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
