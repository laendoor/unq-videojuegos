extends Node

export (PackedScene) var turret: PackedScene

var rng: RandomNumberGenerator = RandomNumberGenerator.new()

onready var player: Sprite = $Player
onready var random = RandomNumberGenerator.new().randomize()

func _ready() -> void:
	rng.randomize()
	var amount_of_turrets = rng.randi_range(2, 5)
	player.initialize(self)
	
	var x_position = rng.randi_range(50, 100)
	var y_position = rng.randi_range(50, 100)
	for number in range(0, amount_of_turrets):
		var new_turret = turret.instance()
		self.add_child(new_turret)
		new_turret.initialize(self, Vector2(x_position, y_position))
		x_position = min(rng.randi_range(x_position + 100, x_position + 200), 850)
		y_position = rng.randi_range(50, 150)
