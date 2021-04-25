extends Behaviour

export var mine_amount: int = 5

var mining := false

onready var dig_timer: Timer = $DigTimer
onready var mine_amount_label: Label = $MineAmountLabel
onready var walk_behaviour: PackedScene = load("res://Behaviours/WalkBehaviour.tscn")


func _ready() -> void:
	._ready()


func set_mine_amount(value: int):
	mine_amount = value
	mine_amount_label.text = str(mine_amount)


func _physics_process(_delta):
	dwarf.velocity.x = 0
	
	if mining:
		return
	
	if dwarf.is_colliding(Vector2.DOWN):
		if mine_amount > 0:
			mine()
		else:
			var walk = dwarf.set_behaviour(walk_behaviour)
			walk.set_moving_right(true)
	else:
		pass # fall animation

func mine():
	mining = true
	dig_timer.start()


func _on_DigTimer_timeout():
	mining = false
	mine_amount -= 1
	if mine_amount == 0:
		mine_amount_label.text = ""
	else:
		mine_amount_label.text = str(mine_amount)
	G.map.mine_tile(dwarf.global_position + (Vector2.DOWN * 10))
