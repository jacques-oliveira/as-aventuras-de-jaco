extends Control

@onready var selectBtnPlay = $MarginContainer/VBoxContainer/HBoxContainer/TextureRect
@onready var selectBtnExit = $MarginContainer/VBoxContainer/HBoxContainer2/TextureRect

func _ready() -> void:
	selectBtnPlay.visible = true
	selectBtnExit.visible = false
	
func _on_play_pressed() -> void:
	get_tree().change_scene_to_file("res://Level_01_Island.tscn")

func _on_exit_pressed() -> void:
	get_tree().quit()


func _on_play_mouse_entered() -> void:
	selectBtnPlay.visible = true # Replace with function body.


func _on_play_mouse_exited() -> void:
	selectBtnPlay.visible = false # Replace with function body.


func _on_exit_mouse_entered() -> void:
	selectBtnExit.visible = true


func _on_exit_mouse_exited() -> void:
	selectBtnExit.visible = false
