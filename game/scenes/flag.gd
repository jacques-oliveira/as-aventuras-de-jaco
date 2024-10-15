extends Node2D

@onready var flagAudioPoint = $flagAudio

func _on_flag_area_body_entered(body: Node2D) -> void:
	flagAudioPoint.play()
	await get_tree().create_timer(3.5).timeout
	get_tree().change_scene_to_file("res://win_scene.tscn")	
