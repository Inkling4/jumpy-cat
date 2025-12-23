extends Node2D

@export var path_follow_2d : PathFollow2D

@export var platform_speed : float = 200

@export var forward : bool = true

var length : float

# Sets path to max value, stores the distance at the time in a property.
func _ready() -> void:
	if (path_follow_2d):
		var _start_progress = path_follow_2d.progress
		path_follow_2d.progress_ratio = 1
		length = path_follow_2d.progress
		path_follow_2d.progress = _start_progress
	else:
		print("Moving Platform _ready failed! (null reference)")

func _physics_process(delta: float) -> void:
	if (path_follow_2d):
		var _current_progress : float = path_follow_2d.progress
		# Moves
		if (forward):
			_current_progress += platform_speed * delta
			if (_current_progress >= length):
				path_follow_2d.progress = length
				forward = false
			else:
				path_follow_2d.progress = _current_progress
		else:
			_current_progress -= platform_speed * delta
			if (_current_progress <= 0):
				path_follow_2d.progress = 0
				forward = true
			else:
				path_follow_2d.progress = _current_progress
		
		print ("Platform progress: ", path_follow_2d.progress)
	
