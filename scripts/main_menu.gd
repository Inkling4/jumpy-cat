extends Node2D

@export var default_level : PackedScene

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


func _on_play_button_released() -> void:
	get_tree().change_scene_to_packed(default_level)
