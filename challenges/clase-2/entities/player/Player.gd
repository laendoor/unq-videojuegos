extends Sprite

export (float) var distance = 50

var leftLimit: float = 0
var rightLimit: float = 530

func _process(delta):
	var left:bool = Input.is_key_pressed(KEY_LEFT)
	var right:bool = Input.is_key_pressed(KEY_RIGHT)
	var direction:float = int(right) - int(left)
	var newPosition:float = position.x + (direction * distance * delta)
	if newPosition > leftLimit && newPosition < rightLimit :
		position.x = newPosition
