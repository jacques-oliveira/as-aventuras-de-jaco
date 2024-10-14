extends RigidBody2D
var speed = 100
var enemyLife = 2
var player_chase = false
var player = null
@onready var emenyDeathSound = $deathSound

func _ready() -> void:
	$AnimatedSprite2D.play("idle")
	enemyLife = 2
	
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
	print_debug("got bullet " + body.name)
	if body.is_in_group("player"):
		player = body
		player_chase = true

func _on_detection_area_body_exited(body: Node2D) -> void:
	if body.is_in_group("player"):
		await get_tree().create_timer(1.5).timeout
		player = null
		player_chase = false	

func _on_enemy_damage_body_entered(body: Node2D) -> void:
	print_debug("got bullet enemy_damage" + body.name)
	if body.is_in_group("bullet"):
		enemyLife-=1
		body.queue_free()
		if enemyLife <= 0:
			emenyDeathSound.play()
			await get_tree().create_timer(0.4).timeout
			queue_free()
			
