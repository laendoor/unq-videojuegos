extends Sprite

const LEFT_LIMIT: float = 10.0
const RIGHT_LIMIT: float = 780.0
const ACCELERATION: float = 10.0
const SPEED_LIMIT: float = 1000.0
const FRICTION_WEIGHT: float = 0.1

export (float) var speed: float = 200 # Pixeles

onready var cannon: Sprite = $Cannon

func initialize(container_node: Node) -> void:
	cannon.initialize(container_node)

func _physics_process(delta: float) -> void:
	var direction_pressed: float = _direction_pressed()
	var new_speed: float = _new_speed(direction_pressed)
	var new_position: Vector2 = _new_position(delta, new_speed)
	
	# Movement
	if _can_move_to(new_position):
		speed = new_speed
		position = new_position
	else: # without this else, speed is accumulated when player is in borders and key preesed
		speed = 0
	
	# Gun
	cannon.point_to(get_local_mouse_position())
	if _is_fire_pressed():
		cannon.fire()

func _direction_pressed() -> float:
	var is_left_pressed: bool = Input.is_action_pressed("ui_left")
	var is_right_pressed: bool = Input.is_action_pressed("ui_right")
	return float(is_right_pressed) - float(is_left_pressed)

func _new_speed(direction_pressed: float) -> float:
	if direction_pressed != 0.0:
		return clamp(speed + (direction_pressed * ACCELERATION), -SPEED_LIMIT, SPEED_LIMIT)
	return lerp(speed, 0, FRICTION_WEIGHT) if abs(speed) > 0 else 0

func _new_position(delta: float, new_speed: float) -> Vector2:
	return Vector2(position.x + (new_speed * delta), position.y)

func _is_fire_pressed() -> bool:
	return Input.is_action_just_pressed("fire")

func _can_move_to(position: Vector2) -> bool:
	return position.x > LEFT_LIMIT && position.x < RIGHT_LIMIT
