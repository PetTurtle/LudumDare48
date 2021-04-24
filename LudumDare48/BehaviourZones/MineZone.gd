extends Area2D

export var mine_amount: int = 5
onready var mine_behaviour: PackedScene = load("res://Behaviours/MiningBehaviour.tscn")


func _on_Node2D_body_entered(body) -> void:
	var dwarf: PhysicsBody2D = body

	if dwarf.position.x < position.x:
		var mine = dwarf.set_behaviour(mine_behaviour)
		mine.mine_amount = mine_amount
		mine.set_moving_right(true)
	else:
		var mine =  dwarf.set_behaviour(mine_behaviour)
		mine.mine_amount = mine_amount
		mine.set_moving_right(false)
	
	queue_free()
