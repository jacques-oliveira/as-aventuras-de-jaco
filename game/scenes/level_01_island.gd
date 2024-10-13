extends Node2D
@onready var heartsContainer = $TileMap/CanvasLayer/heartsContainer
@onready var player = $TileMap/Player

func _ready() -> void:
	heartsContainer.setMaxHearts(player.maxHealth)
	heartsContainer.updateHearts(player.currentHealth)
	player.healthChanged.connect(heartsContainer.updateHearts)
	$TileMap/MainSceneAudio.volume_db+=10
