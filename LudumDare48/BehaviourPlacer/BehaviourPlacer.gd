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


func _init():
	G.set_behaviour_placer(self)


func _ready():
	set_process(false)


func _process(_delta):
	var mouse_point = G.map.get_clamped(get_global_mouse_position())
	if not placed:
		behaviour.position = mouse_point
	elif placed and drag_mode:
		if drag_axis == Vector2.AXIS_X:
			mouse_point.y = behaviour.position.y
			arrow.rotation = 0
			arrow.flip_h = mouse_point.x < behaviour.position.x
		else:
			mouse_point.x = behaviour.position.x
			arrow.rotation = PI * 0.5
			arrow.flip_h = mouse_point.y < behaviour.position.y
		
		if behaviour.position.distance_to(mouse_point) <= drag_max_distance:
			arrow.position = mouse_point
			line.points[1] = mouse_point
			line.visible = true
			arrow.visible = true
	
	if Input.is_action_just_pressed("place_start"):
		placed = true
		line.points[0] = mouse_point
	
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


func place(packed_scene: PackedScene, drag: bool, axis: int, max_distance: int):
	if is_processing():
		behaviour.queue_free()
		line.visible = false
		arrow.visible = false
	
	set_process(true)
	placed = false
	behaviour = packed_scene.instance()
	behaviour.collision_mask -= pow(2, 2) # remove dwarf collision mask
	G.behaviours.add_child(behaviour)
	drag_mode = drag
	drag_axis = axis
	drag_max_distance = max_distance * G.map.get_cell_size()


func finish():
	set_process(false)
	behaviour.collision_mask += pow(2, 2) # set dwarf collision mask
	if drag_mode:
		behaviour.mine_amount = int(round(line.points[0].distance_to(line.points[1]) / G.map.get_cell_size()))
	behaviour = null
	line.visible = false
	arrow.visible = false


func cancel():
	set_process(false)
	behaviour.queue_free()
	line.visible = false
	arrow.visible = false
