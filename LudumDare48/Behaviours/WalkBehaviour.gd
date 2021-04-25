extends Behaviour

onready var move_speed := G.dwarf_speed
onready var walk_behaviour: PackedScene = load("res://Behaviours/WalkBehaviour.tscn")


func _ready() -> void:
	._ready()


func set_moving_right(value: bool) -> void:
	if value:
		move_speed = G.dwarf_speed
	else:
		move_speed = -G.dwarf_speed


func moving_right() -> bool:
	return move_speed > 0


func moving_left() -> bool:
	return move_speed < 0


func _physics_process(_delta) -> void:
	if not dwarf.is_colliding(Vector2.DOWN):
		dwarf.set_animation("climb")
	else:
		dwarf.set_animation("walk")
	
	if dwarf.is_long_colliding():
		dwarf.velocity.x = 0
		return
	
	if moving_right() and dwarf.is_colliding(Vector2.RIGHT):
		var walk = dwarf.set_behaviour(walk_behaviour)
		walk.set_moving_right(false)
	elif moving_left() and dwarf.is_colliding(Vector2.LEFT):
		var walk = dwarf.set_behaviour(walk_behaviour)
		walk.set_moving_right(true)

	dwarf.velocity.x = move_speed
