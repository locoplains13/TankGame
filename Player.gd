extends CharacterBody3D

@export var speed = 0.4
@export var angular_acceleration = 4

var targetVelocity = Vector3.ZERO
var last_direction = Vector3()

var bullet = load("res://bullet.tscn")
var instance

@onready var character = $Pivot/Character
@onready var cannon = $Pivot/Character/Node3D/RayCast3D
@onready var shoot_cooldown = $ShootCooldown



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
	if Input.is_action_pressed("shoot"):
		shoot()
	move_and_slide()
	
	if direction:
		last_direction = direction.normalized()

	targetVelocity.x = direction.x * speed
	targetVelocity.z = direction.z * speed
	
	character.rotation.y = lerp_angle(character.rotation.y, atan2(-last_direction.x, -last_direction.z), delta * angular_acceleration)
	
	velocity = targetVelocity
	
func _process(delta):
	look_at_cursor()

func look_at_cursor():
	var target_plane_mouse = Plane(Vector3(0,1,0), position.y)
	var ray_length = 1000
	var mouse_position = get_viewport().get_mouse_position()
	var from = $"../Camera/Camera3D".project_ray_origin(mouse_position)
	var to = from + $"../Camera/Camera3D".project_ray_normal(mouse_position) * ray_length
	var cursor_position_on_screen = target_plane_mouse.intersects_ray(from, to)
	$Pivot/Character/Node3D.look_at(cursor_position_on_screen, Vector3.UP, 0)

func shoot():
	if shoot_cooldown.is_stopped():
		print("shooting...")
		instance = bullet.instantiate()
		instance.position = cannon.global_position
		instance.transform.basis = cannon.global_transform.basis
		get_parent().add_child(instance)
		shoot_cooldown.start()
