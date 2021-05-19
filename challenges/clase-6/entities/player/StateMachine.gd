extends Node
class_name StateMachine

var parent: Node
var state: int setget set_state
var prev_state: int

func _ready():
	set_physics_process(false)

func initialize(parent: Node):
	self.parent = parent
	set_physics_process(true)

func _physics_process(delta):
	if state != null:
		_state_logic(delta)
		var transition = _get_transition(delta)
		if transition != null:
			set_state(transition)

func _state_logic(delta):
	pass

func _get_transition(delta):
	return null

func _enter_state(new_state: int):
	pass

func _exit_state(old_state: int):
	pass

func set_state(new_state: int):
	prev_state = self.state
	state = new_state
	
	if prev_state != null:
		_exit_state(prev_state)
	
	if new_state != null:
		_enter_state(new_state)
