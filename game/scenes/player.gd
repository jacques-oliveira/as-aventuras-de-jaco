extends CharacterBody2D

signal healthChanged
const SPEED = 325.0
@export var maxHealth = 5
@onready var currentHealth: int = maxHealth
@onready var effects = $Effects
var startPosition = Vector2(-522,481)

func _ready() -> void:
	effects.play("RESET")

func _physics_process(delta):

#	variables direction
	var directionx = Input.get_axis("ui_left", "ui_right")
	var directiony = Input.get_axis("ui_up", "ui_down")
#	move character
	if directionx:
		velocity.x = directionx * SPEED
		
		if directionx > 0:
			$AnimatedSprite2D.flip_h = false
			$AnimatedSprite2D.play("walk_right")
		else:
			$AnimatedSprite2D.flip_h = true
			$AnimatedSprite2D.play("walk_right")
	else:
		velocity.x = move_toward(velocity.x,0, SPEED)
		
	if directiony:
		velocity.y = directiony * SPEED
		
		if directiony > 0:
			$AnimatedSprite2D.play("walk_down")
		else:
			$AnimatedSprite2D.play("walk_up")
	else:
		velocity.y = move_toward(velocity.y,0, SPEED)
		
	if directionx == 0 and directiony == 0:
		$AnimatedSprite2D.stop()
	
	move_and_slide()

func teleporte(area:Area2D) -> void:
	for portal in get_tree().get_nodes_in_group("Portal"):
		if portal != area:
			if (portal.id == area.id):
				if (!portal.portal_is_locked):
					area.lock_portal()
					global_position = portal.global_position

func _on_portal_detector_area_entered(area: Area2D) -> void:
	if area.is_in_group("Portal"):
		if(!area.portal_is_locked):
			area.portalSound.play()
			teleporte(area)
	
func _on_health_detector_area_entered(area: Area2D) -> void:
	if area.name == "enemy_damage":
		currentHealth -= 1
		if currentHealth < 0:
			currentHealth = maxHealth
			position = startPosition
		healthChanged.emit(currentHealth)
		effects.play("hurtBlink")
		await get_tree().create_timer(0.5).timeout
		effects.play("RESET")