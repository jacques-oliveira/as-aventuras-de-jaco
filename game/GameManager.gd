extends Node

var cointCount
var enemyiesOnScene 
signal disableWoodFence

func _ready() -> void:
	cointCount =  0
	enemyiesOnScene = 0

func _on_received_enemy_info(canDisable:bool) -> void:
	if canDisable:
		emit_signal("disableWoodFence", canDisable)
