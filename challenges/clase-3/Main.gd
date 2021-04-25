extends Node

export (PackedScene) var turret: PackedScene

var rng: RandomNumberGenerator = RandomNumberGenerator.new()

onready var player: Sprite = $Player
onready var random = RandomNumberGenerator.new().randomize()

func _ready() -> void:
	rng.randomize()
	player.initialize(self)
	_initialize_turrets(rng.randi_range(2, 5))

func _initialize_turrets(amount_of_turrets: int) -> void:
	var turret_position = Vector2(rng.randf_range(50, 100), rng.randf_range(50, 100))
	for number in range(0, amount_of_turrets):
		var new_turret = turret.instance()
		self.add_child(new_turret)
		new_turret.initialize(self, turret_position)
		turret_position = Vector2(_next_random_x(turret_position), _next_random_y(turret_position))

func _next_random_x(position: Vector2) -> float:
	return min(rng.randf_range(position.x + 100, position.x + 200), 850)

func _next_random_y(position: Vector2) -> float:
	return rng.randf_range(50, 150)
