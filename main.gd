extends Node3D


@export var snow_ball_prefab: PackedScene

@onready var snow_globe = $SnowGlobe
@onready var snowball_emitter = $SnowGlobe/SnowballEmitter

		
func _input(event):
	if event.is_action_pressed("click") and screen_point_to_ray() != null:
		snowball_emitter.spawn_snowballs(20)
		snow_globe.shake()
		
	if event.is_action_released("exit"):
		get_tree().quit()
		
func screen_point_to_ray():
	var space_state = get_world_3d().direct_space_state
	var mouse_pos = get_viewport().get_mouse_position()
	var camera = get_tree().root.get_camera_3d()
	var ray_origin = camera.project_ray_origin(mouse_pos)
	var ray_end = ray_origin + camera.project_ray_normal(mouse_pos) * 2000
	var ray_array = space_state.intersect_ray(PhysicsRayQueryParameters3D.create(ray_origin, ray_end))
	if ray_array.has("position"):
		return ray_array["position"]
	
