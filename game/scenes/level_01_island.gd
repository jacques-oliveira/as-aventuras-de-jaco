extends Node2D
@onready var heartsContainer = $TileMap/CanvasLayer/heartsContainer
@onready var player = $TileMap/Player
@onready var lifeCount = 3
@onready var lifeLabel = $TileMap/CanvasLayer/HBoxContainer/LifeCount

func _ready() -> void:
	player.connect("lostAllHearts",Callable(self,"_on_lostAllHearts"))
	
	lifeLabel.text = "X" + str(lifeCount)
	heartsContainer.setMaxHearts(player.maxHealth)
	heartsContainer.updateHearts(player.currentHealth)
	player.healthChanged.connect(heartsContainer.updateHearts)
	$TileMap/MainSceneAudio.volume_db+=10
	
func _on_lostAllHearts(currentHealth:int) -> void:
	if currentHealth <= 0 and lifeCount > 0 :
		lifeCount-=1;
		lifeLabel.text = "X" + str(lifeCount)
