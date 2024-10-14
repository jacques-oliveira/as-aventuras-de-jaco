extends CharacterBody2D

func _process(delta: float) -> void:
	move_and_slide()

func setVelocity(x:float, y:float):
	velocity = Vector2(x, y)

func _on_bullet_area_area_entered(area: Area2D) -> void:
	queue_free()

func _on_bullet_area_body_entered(body: Node2D) -> void:
	queue_free()
