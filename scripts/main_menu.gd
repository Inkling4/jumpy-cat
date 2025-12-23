extends Node2D

# Level that opens when you press the play button.
@export var default_level : PackedScene


func _on_play_button_released() -> void:
	get_tree().change_scene_to_packed(default_level)
