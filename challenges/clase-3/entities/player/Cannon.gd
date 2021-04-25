extends Sprite

export (PackedScene) var projectile_scene: PackedScene

var _container: Node
const LEFT_BOUND_ANGLE: float = -PI + 0.15
const RIGHT_BOUND_ANGLE: float = 0 - 0.15

onready var fire_position = $FirePosition

func initialize(container_node: Node):
	_container = container_node

func fire() -> void:
	var new_projectile = projectile_scene.instance()
	var from_position = fire_position.global_position
	var to_position = (fire_position.global_position - global_position).normalized()
	_container.add_child(new_projectile)
	new_projectile.initialize(_container, from_position, to_position)

func point_to(position: Vector2) -> void:
	var new_angle = position.normalized().angle()

	# Lower right quadrant
	if new_angle < PI / 2 && new_angle > RIGHT_BOUND_ANGLE:
		rotation = RIGHT_BOUND_ANGLE
		return
	
	# Lower left quadrant
	if new_angle >= PI / 2 || new_angle < LEFT_BOUND_ANGLE:
		rotation = LEFT_BOUND_ANGLE
		return
	
	rotation = new_angle
