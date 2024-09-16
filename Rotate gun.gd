extends Node3D

var ray_origin = Vector3()
var ray_target = Vector3()


func _physics_process(delta):
	var space_state = get_world_3d().direct_space_state
	var parameters = PhysicsRayQueryParameters3D.create(ray_origin,ray_target,1,[self])
	var ray = space_state.intersect_ray(parameters)
	
	if ray:
		var ray_collision_point = ray.position
		var object_position = get_position()
		ray_collision_point = object_position-ray_collision_point
		var angle = Vector2(ray_collision_point.x, ray_collision_point.z).angle_to(Vector2(object_position.x, object_position.z))
		self.set_rotation(Vector3(0,angle,0))

func _input(event):
	if event.is_action_pressed("shoot"):
		print("shooting")

	# make the gun follow cursor
	var cam = $"../../../../Camera/Camera3D"
		
	if event is InputEventMouseMotion:
		ray_origin = cam.project_ray_origin(get_viewport().get_mouse_position())
		ray_target = cam.project_ray_normal(get_viewport().get_mouse_position())*1000
