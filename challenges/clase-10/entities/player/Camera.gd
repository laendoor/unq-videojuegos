extends Camera2D

onready var animation = $AnimationPlayer

func on_ice_started():
	animation.play("Camera")

func on_ice_stopped():
	animation.stop()
	offset = Vector2.ZERO
	zoom = Vector2.ONE
