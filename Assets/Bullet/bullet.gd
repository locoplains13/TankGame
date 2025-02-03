extends CharacterBody3D

const SPEED = 30

@onready var mesh = $MeshInstance3D
@onready var ray = $RayCast3D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	position += global_basis * Vector3.FORWARD * SPEED * delta
	if ray.is_colliding():
		var position_normal = ray.get_collision_normal()
		velocity = velocity.bounce(position_normal)
		queue_free()
