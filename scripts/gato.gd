class_name Gato
extends CharacterBody2D

@export var AudioPlayer : AudioStreamPlayer2D

# Is true while player holds the finger down/is dragging the aim.
var is_dragging := false
var is_draggable : bool


# Gravity modifier
@export var gravity : float
@export var y_launch_speed_limit : float
@export var x_launch_speed_limit : float
@export var friction : float

var mouse_pos_start : Vector2
var mouse_pos_current : Vector2
# Position difference between drag start and current mouse pos
var drag_length : float
# Unit vector for direction
var drag_direction : Vector2


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


func _physics_process(delta: float) -> void:
	
	check_draggable_state()
	# Sound
	if (!is_on_floor() and !AudioPlayer.playing):
		AudioPlayer.play()
	elif (is_on_floor()):
		AudioPlayer.stop()
	
	# Gravity
	if (!is_on_floor()):
		var _velocity = velocity
		_velocity.y = _velocity.y + gravity * delta
		velocity = _velocity
	
	if (is_dragging):
		mouse_pos_current = get_global_mouse_position()
		drag_length = mouse_pos_start.distance_to(mouse_pos_current)
		
		var _direction : Vector2
		_direction.x = (mouse_pos_current.x - mouse_pos_start.x) * -1
		_direction.y = (mouse_pos_current.y - mouse_pos_start.y) * -1
		_direction.x = _direction.x / drag_length
		_direction.y = _direction.y / drag_length
		# Applies direction
		drag_direction = _direction
	move_and_slide()
	
	
	if (is_on_floor()):
		velocity.x = move_toward(velocity.x, 0, delta * friction)

func _input(event: InputEvent) -> void:
	if (is_draggable):
		
		if (event.is_action_pressed("player_drag")):
			is_dragging = true
			mouse_pos_start = get_global_mouse_position()
		
		if (event.is_action_released("player_drag")):
			is_dragging = false
			
			if (is_draggable):
				launch()
			# After launch, sets values to default
			drag_length = 0
			drag_direction.x = 0
			drag_direction.y = 0
			mouse_pos_start.x = 0
			mouse_pos_start.y = 0

func launch() -> void:
	var _velocity = velocity
	_velocity.x = clamp(drag_length, 0, x_launch_speed_limit) * drag_direction.x
	_velocity.y = clamp(drag_length, 0, y_launch_speed_limit) * drag_direction.y
	velocity = _velocity

func check_draggable_state() -> void:
	if (is_on_floor()):
		is_draggable = true
	else:
		is_draggable = false
