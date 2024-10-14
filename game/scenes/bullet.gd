extends RigidBody2D

var speed = 1000.0
@export var velocity= Vector2(1,0)

func _process(delta: float) -> void:
	print_debug(velocity)
	move_and_collide(velocity.normalized() * delta * speed)
