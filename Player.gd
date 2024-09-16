extends CharacterBody3D

@export var speed = 0.4
@export var angular_acceleration = 4

var targetVelocity = Vector3.ZERO
var last_direction = Vector3()

@onready var character = $Pivot/Character

func _physics_process(delta):
	var direction = Vector3()
	# move the player in that direction and rotate it to where it's moving
	
	if Input.is_action_pressed("right"):
		direction.z -= 1
		print("moving right")
	if Input.is_action_pressed("left"):
		direction.z += 1
	if Input.is_action_pressed("down"):
		direction.x += 1
	if Input.is_action_pressed("up"):
		direction.x -= 1
	move_and_slide()
	
	if direction:
		last_direction = direction.normalized()

	targetVelocity.x = direction.x * speed
	targetVelocity.z = direction.z * speed
	
	character.rotation.y = lerp_angle(character.rotation.y, atan2(-last_direction.x, -last_direction.z), delta * angular_acceleration)
	
	velocity = targetVelocity
	
	


func shoot():
	print("shooting...")
