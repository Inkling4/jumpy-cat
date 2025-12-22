class_name Gato
extends CharacterBody2D

# Is true while player holds the finger down/is dragging the aim.
var is_dragging : bool


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	pass
	
	
func _input(event: InputEvent) -> void:
	
	if (event.is_action_just_pressed("player_drag")):
		is_dragging = true
