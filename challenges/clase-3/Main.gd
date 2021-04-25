extends Node

export (PackedScene) var turret: PackedScene

onready var player: Sprite = $Player

func _ready() -> void:
	var new_turret = turret.instance()
	self.add_child(new_turret)
	player.initialize(self)
	new_turret.initialize(self, Vector2(100, 100))
