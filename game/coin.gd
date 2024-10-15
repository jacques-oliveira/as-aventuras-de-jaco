extends CharacterBody2D

@onready var coinAudio = $coinAudio

func _on_coin_collect_body_entered(body: Node2D) -> void:
	print_debug("Coin collide" + body.name)
	if body.is_in_group("player"):
		coinAudio.play()
		await get_tree().create_timer(0.32).timeout
		queue_free()
