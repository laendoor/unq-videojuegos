extends "res://entities/player/StateMachine.gd"

enum STATES {
	IDLE
	WALK,
	JUMP1,
	JUMP2,
	ROLL,
	DEAD,
}

var animations_map: Dictionary = {
	STATES.IDLE:  "idle",
	STATES.WALK:  "walk",
	STATES.JUMP1: "jump",
	STATES.JUMP2: "jump",
	STATES.ROLL:  "roll",
	STATES.DEAD:  "dead",
}

func initialize(parent):
	.initialize(parent)
	call_deferred("set_state", STATES.IDLE)

func _state_logic(_delta):
	if _is_dead():
		set_state(STATES.DEAD)
		return
	
	match(state):
		STATES.IDLE:
			parent._handle_cannon_actions()
			parent._handle_deacceleration()
			parent._handle_move_input()
			parent._apply_movement()
			if parent.is_on_floor() && _wants_to_walk():
				set_state(STATES.WALK)
			if parent.is_on_floor() && _wants_to_jump():
				set_state(STATES.JUMP1)
			if parent.is_on_floor() && _wants_to_roll():
				set_state(STATES.ROLL)
		
		STATES.WALK:
			parent._handle_cannon_actions()
			parent._handle_move_input()
			parent._apply_movement()
			if parent.move_direction == 0:
				set_state(STATES.IDLE)
			if parent.is_on_floor() && _wants_to_jump():
				set_state(STATES.JUMP1)
			if parent.is_on_floor() && _wants_to_roll():
					set_state(STATES.ROLL)
		
		STATES.JUMP1:
			parent._handle_cannon_actions()
			parent._handle_move_input()
			parent._apply_movement()
			if _wants_to_jump():
				set_state(STATES.JUMP2)
		
		STATES.ROLL:
			parent._handle_cannon_actions()
			parent._handle_move_input()
			parent._apply_movement()
		
		STATES.JUMP2:
			parent._handle_cannon_actions()
			parent._handle_move_input()
			parent._apply_movement()

func _is_dead() -> bool:
	return PlayerData.current_health == 0

func _jump():
	parent.snap_vector = Vector2.ZERO
	parent.velocity.y = -parent.jump_speed

func _roll():
	parent.snap_vector = Vector2.ZERO
	parent.velocity.x = parent.H_SPEED_LIMIT * (1 if parent.velocity.x > 0 else -1)

func finish_jump():
	set_state(STATES.IDLE)

func _enter_state(new_state):
	if STATES.DEAD:
		parent.emit_signal("dead")
	if new_state == STATES.JUMP1 || new_state == STATES.JUMP2:
		_jump()
	if new_state == STATES.ROLL:
		_roll()
	
	if new_state >= 0:
		parent._play_animation(animations_map[new_state])

func _exit_state(_old_state):
	pass

func _wants_to_walk() -> bool:
	return Input.is_action_pressed("move_left") || Input.is_action_pressed("move_right")

func _wants_to_jump() -> bool:
	return Input.is_action_just_pressed("jump")

func _wants_to_roll() -> bool:
	return Input.is_action_just_pressed("roll")
