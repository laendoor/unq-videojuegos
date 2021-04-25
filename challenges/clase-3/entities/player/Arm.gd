extends Sprite

export (PackedScene) var projectile_scene: PackedScene

var _container: Node

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
	rotation = position.normalized().angle()
