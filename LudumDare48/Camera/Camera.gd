extends Node2D

export var top_limit: float = 0
export var bottom_limit: float = 1000
export var drag_multi: float = 2

var drag_start_pos: Vector2
var drag_start_camera_pos: Vector2


func _process(_delta) -> void:
	if Input.is_action_just_pressed("camera_drag"):
		drag_start_pos = get_local_mouse_position()
		drag_start_camera_pos = position
	elif Input.is_action_pressed("camera_drag"):
		var curr_pos := get_local_mouse_position()
		var new_pos_y := drag_start_camera_pos.y + (drag_start_pos.y - curr_pos.y) * drag_multi
		position = Vector2(0, clamp(new_pos_y, top_limit, bottom_limit)) 
