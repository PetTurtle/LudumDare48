extends Node2D

var move_speed = 400
export var top_limit: float = 0
export var bottom_limit: float = 1000
export var drag_multi: float = 2

var drag_start_pos: Vector2
var drag_start_camera_pos: Vector2


func _process(delta) -> void:
	if Input.is_action_just_pressed("camera_drag"):
		drag_start_pos = get_local_mouse_position()
		drag_start_camera_pos = position
	elif Input.is_action_pressed("camera_drag"):
		var curr_pos := get_local_mouse_position()
		var new_pos_y := drag_start_camera_pos.y + (drag_start_pos.y - curr_pos.y) * drag_multi
		position = Vector2(0, clamp(new_pos_y, top_limit, bottom_limit))
	elif Input.is_action_pressed("move_up"):
		position = Vector2(0, clamp(position.y - (move_speed * delta), top_limit, bottom_limit))
	elif Input.is_action_pressed("move_down"):
		position = Vector2(0, clamp(position.y + (move_speed * delta), top_limit, bottom_limit))
