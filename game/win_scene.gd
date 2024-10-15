extends Control

@onready var coinScoreLabel = $MarginContainer/VBoxContainer/CanvasLayer/CoinGUI/labelCointCount

func _ready() -> void:
	coinScoreLabel.text = "X" + str(GameManager.cointCount)
