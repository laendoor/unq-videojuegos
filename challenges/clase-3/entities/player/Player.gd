extends Sprite

export (float) var speed = 200 # Pixeles

var leftLimit: float = 0
var rightLimit: float = 800

onready var arm: Sprite = $Arm

func initialize(projectile_container):
		arm.container = projectile_container

func _physics_process(delta):
	var left: bool = Input.is_action_pressed("ui_left")
	var right: bool = Input.is_action_pressed("ui_right")
	var direction: float = int(right) - int(left)
	var newPosition: float = position.x + (direction * speed * delta)
	
	var mouse_position: Vector2 = get_local_mouse_position()
	arm.rotation = mouse_position.normalized().angle()
	
	if Input.is_action_just_pressed("fire"):
		arm.fire()
	
	if newPosition > leftLimit && newPosition < rightLimit:
		position.x = newPosition

