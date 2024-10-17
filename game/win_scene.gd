extends Control

@onready var coinScoreLabel = $MarginContainer/VBoxContainer/CanvasLayer/CoinGUI/labelCointCount
@onready var particle = $GPUParticles2D
@onready var pressButton = $pressButton

func _ready() -> void:
	coinScoreLabel.text = "X" + str(GameManager.cointCount)
	particle.emitting = true
	particle.one_shot = true
	particle.restart()

func _input(event: InputEvent) -> void:
	if event.is_action_released("ui_accept") || event.is_action_released("ui_select"):
		pressButton.play()
		await get_tree().create_timer(0.75).timeout
		get_tree().change_scene_to_file("res://scenes/main_menu.tscn")
