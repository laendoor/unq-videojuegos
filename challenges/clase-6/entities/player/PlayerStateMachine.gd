extends "res://entities/player/StateMachine.gd"

enum STATES {
	IDLE
	WALK,
	JUMP1,
	JUMP2,
	DEAD,
}

var animations_map: Dictionary = {
	STATES.IDLE:  "idle",
	STATES.WALK:  "walk",
	STATES.JUMP1: "jump",
	STATES.JUMP2: "jump",
	STATES.DEAD:  "dead",
}

func initialize(parent):
	.initialize(parent)
	call_deferred("set_state", STATES.IDLE)
	print(STATES)

func _state_logic(_delta):
	if state != STATES.DEAD:
		parent._handle_cannon_actions()
	
	if state == STATES.IDLE || state == STATES.DEAD:
		parent._handle_deacceleration()
	else:
		parent._handle_move_input()
	parent._apply_movement()

func _get_transition(_delta):
	if state == STATES.DEAD:
		return STATES.DEAD

	if PlayerData.current_health == 0:
		parent.emit_signal("dead")
		return STATES.DEAD
	
	if _is_alive() && _can_jump():
		parent.snap_vector = Vector2.ZERO
		parent.velocity.y = -parent.jump_speed
		if state == STATES.JUMP1:
			return STATES.JUMP2
		return STATES.JUMP1
	
	if state == STATES.IDLE && _wants_to_walk():
		return STATES.WALK
	
	if state == STATES.WALK && parent.move_direction == 0:
		return STATES.IDLE
	
	if (state == STATES.JUMP1 || state == STATES.JUMP2) && parent.is_on_floor():
		if parent.move_direction != 0:
			return STATES.WALK
		return STATES.IDLE
	
	return null

func _enter_state(new_state):
	parent._play_animation(animations_map[new_state])

func _exit_state(old_state):
	pass

func _is_alive() -> bool:
	return state != STATES.DEAD

func _wants_to_walk() -> bool:
	return Input.is_action_pressed("move_left") || Input.is_action_pressed("move_right")

func _wants_to_jump() -> bool:
	return Input.is_action_just_pressed("jump")

func _can_jump() -> bool:
	return _wants_to_jump() && (parent.is_on_floor() || state == STATES.JUMP1)
