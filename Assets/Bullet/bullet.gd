extends CharacterBody3D

const SPEED = 30

@onready var mesh = $MeshInstance3D
@onready var ray = $RayCast3D
@onready var position_of_shoot = global_position

@export var collision_count = 0


# Called when the node enters the scene tree for the first time.
func _ready():
 # Replace with function body.
	velocity = global_transform.basis * Vector3(0,0,-SPEED)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	var collision := move_and_collide(velocity * delta)
	if collision != null:
		velocity = velocity.bounce(collision.get_normal())
		collision_count += 1
		if collision_count > 1:
			queue_free()
