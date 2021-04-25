extends Sprite

export (PackedScene) var projectile_scene: PackedScene
export (float) var shoot_every: float = 1.0

var _container: Node = null
var rng: RandomNumberGenerator = RandomNumberGenerator.new()

onready var fire_position = $FirePosition
onready var _fire_timer = $FireTimer

func initialize(container: Node, new_position: Vector2) -> void:
	_container = container
	position = new_position

func _ready() -> void:
	rng.randomize()
	_start_fire()

func _start_fire() -> void:
	_fire_timer.connect("timeout", self, "_on_Timer_timeout")
	_fire_timer.set_wait_time(rng.randf_range(shoot_every - 0.3, shoot_every + 0.3))
	_fire_timer.set_one_shot(false) # Make sure it loops
	_fire_timer.start()

func _on_Timer_timeout() -> void:
	_fire()

func _fire() -> void:
	var new_projectile = projectile_scene.instance()
	var player = _container.get_node("Player")
	var from_position = fire_position.global_position
	var to_position = (player.global_position - global_position).normalized()
	_container.add_child(new_projectile)
	new_projectile.initialize(_container, from_position, to_position)
