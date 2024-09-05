extends CharacterBody3D

@export var speed = 10

var targetVelocity = Vector3.ZERO

func _physics_process(delta):
	var direction = Vector3.ZERO
	
	if Input.is_action_pressed("right"):
		direction.z -= 1
		print("moving right")
	if Input.is_action_pressed("left"):
		direction.z += 1
	if Input.is_action_pressed("down"):
		direction.x += 1
	if Input.is_action_pressed("up"):
		direction.x -= 1
	
	if direction != Vector3.ZERO:
		direction = direction.normalized()
		
		$Pivot.basis = Basis.looking_at(direction)

	targetVelocity.x = direction.x * speed
	targetVelocity.z = direction.z * speed
	
	velocity = targetVelocity
	move_and_slide()
