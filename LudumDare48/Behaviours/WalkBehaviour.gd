extends Behaviour

var moving_right := false
var move_speed := 15


func _ready() -> void:
	._ready()


func _physics_process(_delta) -> void:
	if not dwarf.is_colliding(Vector2.DOWN):
		dwarf.set_animation("climb")
	else:
		dwarf.set_animation("walk")
	
	if moving_right and dwarf.is_colliding(Vector2.LEFT):
		moving_right = false
	elif not moving_right and dwarf.is_colliding(Vector2.RIGHT):
		moving_right = true

	if moving_right:
		dwarf.linear_velocity.x = -move_speed
	else:
		dwarf.linear_velocity.x = move_speed
