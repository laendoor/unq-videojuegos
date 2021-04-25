extends Sprite

const LEFT_LIMIT: float = 0.0
const RIGHT_LIMIT: float = 800.0

export (float) var speed: float = 200 # Pixeles

onready var arm: Sprite = $Arm

func initialize(container_node: Node) -> void:
	arm.initialize(container_node)

func _physics_process(delta: float) -> void:
	var new_position: Vector2 = _get_new_position(delta)
	if _can_move_to(new_position):
		position = new_position
	
	arm.point_to(get_local_mouse_position())
	if _is_fire_pressed():
		arm.fire()

func _get_new_position(delta: float) -> Vector2:
	var is_left_pressed: bool = Input.is_action_pressed("ui_left")
	var is_right_pressed: bool = Input.is_action_pressed("ui_right")
	var direction_pressed: float = float(is_right_pressed) - float(is_left_pressed)
	return Vector2(position.x + (direction_pressed * speed * delta), position.y)

func _is_fire_pressed() -> bool:
	return Input.is_action_just_pressed("fire")

func _can_move_to(position: Vector2) -> bool:
	return position.x > LEFT_LIMIT && position.x < RIGHT_LIMIT
