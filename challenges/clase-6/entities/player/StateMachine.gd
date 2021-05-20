extends Node
class_name StateMachine

var parent: Node
var state: int setget set_state
var prev_state: int

func _ready():
	set_physics_process(false)

func initialize(parentNode: Node):
	parent = parentNode
	set_physics_process(true)

func _physics_process(delta):
	if state != null:
		_state_logic(delta)

func _state_logic(_delta):
	pass

func _get_transition(_delta):
	return null

func _enter_state(_new_state: int):
	pass

func _exit_state(_old_state: int):
	pass

func set_state(new_state: int):
	if state != null:
		_exit_state(state)
	
	state = new_state
	if state != null:
		_enter_state(state)
