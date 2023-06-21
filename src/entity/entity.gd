class_name Entity extends CharacterBody3D

@export var health : int = 10
@export var max_health : int = 10
@export var move_speed : float = 4

var move_vec : Vector3 = Vector3.ZERO

func movement_loop(delta : float) -> void:
	move_vec = move_vec.normalized()
	move_vec = move_vec.rotated(Vector3(0, 1, 0), rotation.y)
	print(move_vec)
	move_and_collide(move_vec * move_speed * delta)

func kill() -> void:
	queue_free()
