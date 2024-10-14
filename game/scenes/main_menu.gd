extends Control

@onready var selectBtnPlay = $MarginContainer/VBoxContainer/HBoxContainer/TextureRect
@onready var selectBtnExit = $MarginContainer/VBoxContainer/HBoxContainer2/TextureRect
@onready var btnPlay = $MarginContainer/VBoxContainer/HBoxContainer/play
@onready var btnExit = $MarginContainer/VBoxContainer/HBoxContainer2/exit
@onready var pressAudioButton = $pressButton
@onready var selectAudioButton = $selectButton

var buttons = []

var selectedButton = 0

func _ready() -> void:
	selectBtnPlay.visible = true
	selectBtnExit.visible = false
	buttons.append(btnPlay)  # Nome do botão Play
	buttons.append(btnExit)   # Nome do botão Exit
	
func _on_play_pressed() -> void:	
	if not pressAudioButton.playing:
		pressAudioButton.play()		
	await get_tree().create_timer(0.5).timeout
	get_tree().change_scene_to_file("res://scenes/Level_01_Island.tscn")
	
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
	
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_up"):
		selectBtnPlay.visible = true
		selectBtnExit.visible = false
		selectedButton = 0
		selectAudioButton.play()
	elif event.is_action_pressed("ui_down"):
		selectBtnPlay.visible = false
		selectBtnExit.visible = true
		selectedButton = 1
		selectAudioButton.play()
	elif event.is_action("ui_select"):
		#buttons[selectedButton].press()
		match (selectedButton):
			0:
				btnPlay.emit_signal("pressed")
			1: 
				btnExit.emit_signal("pressed")	
