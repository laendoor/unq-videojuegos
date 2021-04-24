extends Sprite

export (float) var speed = 200 # Pixeles

var leftLimit: float = 0
var rightLimit: float = 800

func _physics_process(delta):
	var left:bool = Input.is_action_pressed("ui_left")
	var right:bool = Input.is_action_pressed("ui_right")
	var direction:float = int(right) - int(left)
	var newPosition:float = position.x + (direction * speed * delta)
	
	if newPosition > leftLimit && newPosition < rightLimit:
		position.x = newPosition
