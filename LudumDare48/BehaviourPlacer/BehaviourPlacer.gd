extends Node2D

var placed := false
var cancel_point: Vector2
var cancel_distance := 10

var behaviour: Node2D
var place_mode := false
var drag_mode := false
var drag_axis: int
var drag_max_distance: int

onready var line: Line2D = $Line2D
onready var arrow: Sprite = $ArrowSprite
onready var outline: Sprite = $OutlineSprite
onready var collision_checker: Area2D = $CollisionChecker
onready var animation: AnimationPlayer = $OutlineSprite/AnimationPlayer
onready var needs_floor: bool = false

export var valid_color: Color
export var invalid_color: Color


func _init():
	G.set_behaviour_placer(self)


func _ready():
	set_process(false)


func _process(_delta):
	var mouse_point = G.map.get_clamped(get_global_mouse_position())
	if not placed:
		behaviour.position = mouse_point
		outline.position = mouse_point
		if _is_valid_pos(mouse_point):
			outline.modulate = valid_color
		else:
			outline.modulate = invalid_color
	
	elif placed and drag_mode:
		if drag_axis == Vector2.AXIS_X:
			mouse_point.y = behaviour.position.y
			arrow.rotation = 0
			arrow.flip_h = mouse_point.x < behaviour.position.x
		else:
			mouse_point.x = behaviour.position.x
			arrow.rotation = PI * 0.5
			arrow.flip_h = false
		
		if behaviour.position.distance_to(mouse_point) <= drag_max_distance:
			if drag_axis != Vector2.AXIS_Y or mouse_point.y >= behaviour.position.y:
				arrow.position = mouse_point
				line.points[1] = mouse_point
				line.visible = true
				arrow.visible = true
	
	if Input.is_action_just_pressed("place_start"):
		if _is_valid_pos(mouse_point):
			placed = true
			line.points[0] = mouse_point
		else:
			cancel()
	
	elif placed and Input.is_action_just_released("place_start"):
		if drag_mode and line.points[0] == line.points[1]:
			cancel()
		else:
			finish()
	
	elif Input.is_action_just_pressed("place_cancel"):
		cancel_point = get_global_mouse_position()
	
	elif Input.is_action_just_released("place_cancel"):
		if cancel_point.distance_to(get_global_mouse_position()) <= cancel_distance:
			cancel()


func place(packed_scene: PackedScene, drag: bool, axis: int, max_distance: int, _needs_floor: bool):
	if is_processing():
		behaviour.queue_free()
		line.visible = false
		arrow.visible = false
	
	set_process(true)
	outline.visible = true
	placed = false
	behaviour = packed_scene.instance()
	behaviour.collision_mask -= pow(2, 2) # remove dwarf collision mask
	G.behaviours.add_child(behaviour)
	drag_mode = drag
	drag_axis = axis
	drag_max_distance = max_distance * G.map.get_cell_size()
	needs_floor = _needs_floor
	animation.play("Blink")


func finish():
	set_process(false)
	behaviour.collision_mask += pow(2, 2) # set dwarf collision mask
	if drag_mode:
		behaviour.mine_amount = int(round(line.points[0].distance_to(line.points[1]) / G.map.get_cell_size()))
		if drag_axis == Vector2.AXIS_X:
			behaviour.dig_right = line.points[0] < line.points[1]
	behaviour = null
	line.visible = false
	arrow.visible = false
	outline.visible = false
	animation.stop()


func cancel():
	set_process(false)
	behaviour.queue_free()
	line.visible = false
	arrow.visible = false
	outline.visible = false
	animation.stop()


func _is_valid_pos(pos: Vector2):
	collision_checker.position = pos
	if needs_floor and (not G.map.has_floor(pos) or collision_checker.get_overlapping_bodies().size() > 0):
		return false
	return G.map.get_tile(pos) == -1 and collision_checker.get_overlapping_areas().size() <= 1
