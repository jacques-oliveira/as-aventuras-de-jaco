extends StaticBody2D

func _ready() -> void:
	GameManager.connect("disableWoodFence", Callable(self,"_on_fence_disable"))

func _on_fence_disable(disable:bool) -> void:
	queue_free()
	
