extends Node2D
@onready var heartsContainer = $TileMap/CanvasLayer/heartsContainer
@onready var player = $TileMap/Player
@onready var lifeCount
@onready var lifeLabel = $TileMap/CanvasLayer/HBoxContainer/LifeCount
@onready var coin = $TileMap/Coins/Coin/coinCollect
@onready var coinLabel = $TileMap/CanvasLayer/CoinGUI/labelCointCount
@onready var enemies = $TileMap/enemies.get_child_count()

var coinCount

func _ready() -> void:
	GameManager.enemyiesOnScene = enemies
	lifeCount = 3
	coinCount = 0
	player.connect("lostAllHearts",Callable(self,"_on_lostAllHearts"))
	connectCoins()
	coinLabel.text = "X" + str(coinCount)
	lifeLabel.text = "X" + str(lifeCount)
	heartsContainer.setMaxHearts(player.maxHealth)
	heartsContainer.updateHearts(player.currentHealth)
	player.healthChanged.connect(heartsContainer.updateHearts)
	$TileMap/MainSceneAudio.volume_db+=10
	
func _on_lostAllHearts(currentHealth:int) -> void:	
		
	if currentHealth <= 0 and lifeCount > 0 :
		lifeCount-=1;
		lifeLabel.text = "X" + str(lifeCount)
		
	if lifeCount <= 0 :
		call_deferred("_change_scene_to_main_menu")
		
func _change_scene_to_main_menu() -> void:
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn")

func _on_coinCollected() -> void:
	coinCount+=1
	coinLabel.text = "X" + str(coinCount)
	
func connectCoins() -> void:
	for coin in get_tree().get_nodes_in_group("coins"):
		if coin.has_signal("coinCollected"):
			coin.connect("coinCollected", _on_coinCollected)
