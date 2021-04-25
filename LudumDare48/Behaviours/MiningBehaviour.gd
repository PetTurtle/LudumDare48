extends Behaviour

export var mine_amount: int = 5

var mining := false
var mine_dir: Vector2

onready var move_speed := G.dwarf_speed
onready var mine_timer: Timer = $MineTimer
onready var mine_amount_label: Label = $MineAmountLabel
onready var walk_behaviour: PackedScene = load("res://Behaviours/WalkBehaviour.tscn")
onready var audio: AudioStreamPlayer = $AudioStreamPlayer


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


func set_mine_amount(value: int):
	mine_amount = value
	mine_amount_label.text = str(mine_amount)


func _physics_process(_delta):
	if mining:
		dwarf.set_animation("mine")
		return
	
	if not dwarf.is_colliding(Vector2.DOWN):
		dwarf.set_animation("fall")
	else:
		dwarf.set_animation("walk")
	
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
	
	dwarf.velocity.x = move_speed


func mine(direction: Vector2):
	mining = true
	mine_dir = direction
	mine_timer.start()


func _on_MineTimer_timeout():
	mining = false
	mine_amount -= 1
	if mine_amount == 0:
		mine_amount_label.text = ""
	else:
		mine_amount_label.text = str(mine_amount)
	audio.ran_pitch()
	audio.play()
	G.map.mine_tile(dwarf.global_position + (mine_dir * 5))
