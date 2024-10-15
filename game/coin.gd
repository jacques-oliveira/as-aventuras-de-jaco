extends CharacterBody2D

@onready var coinAudio = $coinAudio
@onready var particle = $particle
signal coinCollected

func _ready() -> void:
	particle.emitting = false
	
func _on_coin_collect_body_entered(body: Node2D) -> void:
	#print_debug("Coin collide" + body.name)
	if body.is_in_group("player"):
		coinAudio.play()
		emit_signal("coinCollected")
		particle.emitting = true
		particle.one_shot = true
		particle.restart()
		await get_tree().create_timer(0.45).timeout
		queue_free()
