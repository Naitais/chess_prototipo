class_name StateMachine
extends Node

@export var state: State

func _ready():
	change_state(state)
	
func change_state(new_state: State):
	if state is State:
		state._exit_state()
	
	new_state._enter_state()
	state = new_state

func _process(delta):
	#if Global.selected_piece:
		#if self.get_parent() == Global.selected_piece:
			#print(state)
	
	pass
