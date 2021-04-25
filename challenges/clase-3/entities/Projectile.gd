extends Node2D

export (float) var speed: float = 50

var _parent: Node
var direction: Vector2

onready var timer = $DeleteTimer

func initialize(parent: Node, fire_direction: Vector2, initial_position: Vector2):
	_parent = parent
	global_position = initial_position
	direction = fire_direction
	timer.connect("timeout", self, "_on_DeleteTimer_timeout")
	timer.start()

func _physics_process(delta):
	position += direction * speed * delta

func _on_DeleteTimer_timeout():
	_parent.remove_child(self)
	queue_free()

