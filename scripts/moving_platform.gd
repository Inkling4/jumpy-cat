extends Node2D

@export var path_follow_2d : PathFollow2D

@export var platform_speed : float = 200

@export var forward : bool = true


func _physics_process(delta: float) -> void:
	if (path_follow_2d):
		# Moves
		if (forward):
			path_follow_2d.progress += platform_speed * delta
		else:
			path_follow_2d.progress -= platform_speed * delta
		# Reverses direction at the edges
		if (path_follow_2d.progress >= 1):
			forward = false
		if (path_follow_2d.progress <= 0):
			forward = true
	
