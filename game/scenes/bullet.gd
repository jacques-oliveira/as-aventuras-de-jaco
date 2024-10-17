extends CharacterBody2D

func _process(delta: float) -> void:
	move_and_slide()

func setVelocity(x:float, y:float):
	velocity = Vector2(x, y)

func _on_bullet_area_area_entered(area: Area2D) -> void:	
	if !area.is_in_group("player"):
		#print_debug("SHOOTING AREA"+area.name)
		$Sprite2D.play()
		await get_tree().create_timer(0.28).timeout
		queue_free()

func _on_bullet_area_body_entered(body: Node2D) -> void:
	if !body.is_in_group("player"):
		#print_debug("SHOOTING BODYING"+body.name)
		await get_tree().create_timer(0.25).timeout
		queue_free()
