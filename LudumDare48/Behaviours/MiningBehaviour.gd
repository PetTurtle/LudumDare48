extends Behaviour

export var mine_amount: int = 5

var mining := false

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


func _physics_process(_delta):
	if not dwarf.is_colliding(Vector2.DOWN):
		var walk = dwarf.set_behaviour(walk_behaviour)
		walk.set_moving_right(moving_right())
	
	if moving_right() and dwarf.is_colliding(Vector2.RIGHT):
		if mine_amount > 0:
			mine(Vector2.RIGHT)
		else:
			var walk = dwarf.set_behaviour(walk_behaviour)
			walk.set_moving_right(false)
	elif moving_left() and dwarf.is_colliding(Vector2.LEFT):
		if mine_amount > 0:
			mine(Vector2.LEFT)
		else:
			var walk = dwarf.set_behaviour(walk_behaviour)
			walk.set_moving_right(true)
	
	dwarf.linear_velocity.x = move_speed

func mine(direction: Vector2):
	mine_amount -= 1
	G.map.mine_tile(dwarf.global_position + (direction * 10))
