extends RigidBody2D
var speed = 100
var player_chase = false
var player = null

func _ready() -> void:
	$AnimatedSprite2D.play("idle")
	
func _physics_process(delta: float) -> void:
	if player_chase && player.is_in_group("player") :
		position += (player.position - position)/speed
		$AnimatedSprite2D.play("walk")
		if (player.position.x - position.x) < 0:
			$AnimatedSprite2D.flip_h = true
		else:
			$AnimatedSprite2D.flip_h = false
	else:
		$AnimatedSprite2D.play("idle")
		
func _on_detection_area_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		player = body
		player_chase = true

func _on_detection_area_body_exited(body: Node2D) -> void:
	if body.is_in_group("player"):
		await get_tree().create_timer(2.5).timeout
		player = null
		player_chase = false	
