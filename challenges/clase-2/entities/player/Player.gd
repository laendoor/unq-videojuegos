extends Sprite

export (float) var distance = 50

var leftLimit: float = 250
var rightLimit: float = 750

func _process(delta):
	var left:bool = Input.is_action_pressed("ui_left")
	var right:bool = Input.is_action_pressed("ui_right")
	var direction:float = int(right) - int(left)
	var newPosition:float = position.x + (direction * distance * delta)
	
	if direction != 0:
		flip_h = direction == -1
	if newPosition > leftLimit && newPosition < rightLimit:
		position.x = newPosition
	
