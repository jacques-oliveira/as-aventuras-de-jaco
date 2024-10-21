extends CharacterBody2D

@export var maxHealth = 5
@onready var currentHealth: int = maxHealth
@onready var effects = $Effects
@onready var animatedSprite= $AnimatedSprite2D
@onready var shotLaserSound = $shotLaser
@onready var hurtDamage = $hurtDamage

const SPEED = 325.0
signal healthChanged
signal lostAllHearts
var startPosition = Vector2(-522,481)
var bulletTscn = preload("res://scenes/bullet.tscn")
var canShoot = true
var directionWalk = 0
var lastDirectionX
var lastDirectionY

func _ready() -> void:
	effects.play("RESET")
	lastDirectionX = 1
func _physics_process(delta):

#	variables direction
	var directionx = Input.get_axis("ui_left", "ui_right")
	var directiony = Input.get_axis("ui_up", "ui_down")
#	move character
	if directionx:
		velocity.x = directionx * SPEED
		lastDirectionY = 0
		if directionx > 0:
			$AnimatedSprite2D.flip_h = false
			$AnimatedSprite2D.play("walk_right")
			lastDirectionX = 1
		else:
			$AnimatedSprite2D.flip_h = true
			$AnimatedSprite2D.play("walk_left")
			lastDirectionX = -1 
	else:
		velocity.x = move_toward(velocity.x,0, SPEED)
		
	if directiony:
		velocity.y = directiony * SPEED
		lastDirectionX = 0
		if directiony > 0:
			$AnimatedSprite2D.play("walk_down")
			lastDirectionY = 1
		else:
			$AnimatedSprite2D.play("walk_up")
			lastDirectionY = -1
	else:
		velocity.y = move_toward(velocity.y,0, SPEED)
		
	if directionx == 0 and directiony == 0:
		if lastDirectionX != 0:
			if lastDirectionX == 1:
				$AnimatedSprite2D.play("idle_right")
			else :	
				$AnimatedSprite2D.play("idle_left")
		elif lastDirectionX == 0 and lastDirectionY != 0:
			if lastDirectionY == 1:
				$AnimatedSprite2D.play("idle_down")
			else :	
				$AnimatedSprite2D.play("idle_up")
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
		hurtDamage.play()
		if currentHealth <= 0:
			emit_signal("lostAllHearts",currentHealth)
			currentHealth = maxHealth
			position = startPosition
		healthChanged.emit(currentHealth)
		effects.play("hurtBlink")
		await get_tree().create_timer(0.5).timeout
		effects.play("RESET")

func shoot():
	var bullet =bulletTscn.instantiate()
	get_parent().add_child(bullet)
	var speed = 1500.0
	if animatedSprite.animation == "walk_right" || animatedSprite.animation == "idle_right":
		bullet.setVelocity(speed,0)
		bullet.position = $shootPointWR.global_position	
	elif animatedSprite.animation == "walk_down" || animatedSprite.animation == "idle_down":
		bullet.setVelocity(0,speed)
		bullet.global_rotation = PI/2
		bullet.position = $shootPointDOWN.global_position	
	elif animatedSprite.animation == "walk_left" || animatedSprite.animation == "idle_left":
		bullet.setVelocity(lastDirectionX*speed,0)
		bullet.global_rotation = PI
		bullet.position = $shootPointWL.global_position	
	elif animatedSprite.animation == "walk_up" || animatedSprite.animation == "idle_up":
		bullet.setVelocity(0,-speed)
		bullet.global_rotation = 3*PI/2
		bullet.position = $shootPointUP.global_position	
	else:
		return
						
	canShoot = false
	await get_tree().create_timer(0.25).timeout
	canShoot = true

func _input(event: InputEvent) -> void:
	if Input.is_action_pressed("fire") and canShoot:
		shoot()
		shotLaserSound.play()
