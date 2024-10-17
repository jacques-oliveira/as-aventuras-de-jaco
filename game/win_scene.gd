extends Control

@onready var coinScoreLabel = $MarginContainer/VBoxContainer/CanvasLayer/CoinGUI/labelCointCount
@onready var particle = $GPUParticles2D

func _ready() -> void:
	coinScoreLabel.text = "X" + str(GameManager.cointCount)
	particle.emitting = true
	particle.one_shot = true
	particle.restart()

func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("ui_accept") || Input.is_action_just_released("ui_select"):
		get_tree().change_scene_to_file("res://scenes/main_menu.tscn")
