extends KinematicBody2D

onready var cannon = $Cannon

export (float) var ACCELERATION:float = 20.0
export (float) var H_SPEED_LIMIT:float = 600.0
export (float) var FRICTION_WEIGHT:float = 0.1
export (float) var GRAVITY: float = 10.0
export (float) var JUMP_VELOCITY: float = 400.0

var timer: Timer
var velocity: Vector2 = Vector2.ZERO
var projectile_container

func initialize(projectile_container):
	timer = Timer.new()
	add_child(timer)
	self.projectile_container = projectile_container
	cannon.projectile_container = projectile_container

func _physics_process(delta):
	# Cannon rotation
	var mouse_position: Vector2 = get_global_mouse_position()
	cannon.look_at(mouse_position)
	
	# Cannon fire
	if Input.is_action_just_pressed("fire_cannon"):
		if projectile_container == null:
			projectile_container = get_parent()
			cannon.projectile_container = projectile_container
		cannon.fire()
	
	# Player movement
	var h_movement_direction:int = int(Input.is_action_pressed("move_right")) - int(Input.is_action_pressed("move_left"))
	
	if h_movement_direction != 0:
		velocity.x = clamp(velocity.x + (h_movement_direction * ACCELERATION), -H_SPEED_LIMIT, H_SPEED_LIMIT)
	else:
		velocity.x = lerp(velocity.x, 0, FRICTION_WEIGHT) if abs(velocity.x) > 1 else 0
	
#	move_and_slide(Vector2.DOWN, -Vector2.DOWN) # hackazo para el is_on_floor()
	if is_on_floor():
		velocity.y = 0
	if is_on_floor() and Input.is_action_pressed("jump"):
		velocity.y -= JUMP_VELOCITY
	
	velocity.y += GRAVITY
	print(velocity.y)
	move_and_slide(velocity, Vector2.UP)

func notify_hit():
	$Dead.visible = true
	timer.wait_time = 2.5
	timer.connect("timeout", self, "_on_Timer_timeout")
	timer.start()

func _on_Timer_timeout():
	$Dead.visible = false
