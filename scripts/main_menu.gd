extends Node2D

# Level that opens when you press the play button.
@export var default_level : PackedScene


func _on_play_button_released() -> void:
	if (default_level):
		get_tree().change_scene_to_packed(default_level)
