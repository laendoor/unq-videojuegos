extends AnimatedSprite

onready var area := $Area2D

func _ready():
	playing = true
	scale = Vector2(0.25,0.25)

func _on_Area2D_body_entered(body):
	if body.is_in_group("Player"):
		Global.level_passed()
