extends Node

onready var player: Sprite = $Player

func _ready() -> void:
	player.initialize(self)
