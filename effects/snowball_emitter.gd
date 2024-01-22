extends Node3D


@export var snowball_prefab: PackedScene
@export var snowball_impulse = 20
@export var randomness_multiplier = 7

@onready var spawn_area = $SpawnArea

func spawn_snowballs(amount: int):
	for i in amount:
		spawn_snowball()

func spawn_snowball():
	var snowball: RigidBody3D = snowball_prefab.instantiate()
	add_child(snowball)
	snowball.global_position = get_random_point_in_cylinder(spawn_area.mesh.top_radius, spawn_area.mesh.height, spawn_area.global_position)
	snowball.apply_central_impulse(Vector3(randf_range(-randomness_multiplier, randomness_multiplier), snowball_impulse * randf_range(0.5, 1), randf_range(-randomness_multiplier, randomness_multiplier)))
	
func get_random_point_in_cylinder(radius, height, cylinder_position):
	# Generate random angle
	var angle = randf() * 2.0 * PI
	# Generate random radius
	var rand_radius = sqrt(randf()) * radius
	# Cartesian coordinates for x and z
	var x = rand_radius * cos(angle)
	var z = rand_radius * sin(angle)
	# Random y coordinate within the cylinder's height
	var y = randf() * height
	# Adjust by cylinder's position
	var random_point = Vector3(x, y, z) + cylinder_position
	return random_point
