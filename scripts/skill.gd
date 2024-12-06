extends Node2D
class_name active_skill

@onready var skill_name_lbl = $skill_name_lbl
@export var mana_cost: int
@export var skill_name: String
@export var description: String


# Called when the node enters the scene tree for the first time.
func _ready():
	skill_name_lbl.text = skill_name

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
