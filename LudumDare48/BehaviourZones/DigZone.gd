extends Area2D

export var mine_amount: int = 5
onready var dig_behaviour: PackedScene = load("res://Behaviours/DiggingBehaviour.tscn")


func _on_Area2D_body_entered(body):
	collision_mask = 0
	var dwarf: PhysicsBody2D = body
	dwarf.position.x = position.x

	if dwarf.position.x < position.x:
		var dig = dwarf.set_behaviour(dig_behaviour)
		dig.set_mine_amount(mine_amount)
	else:
		var dig =  dwarf.set_behaviour(dig_behaviour)
		dig.set_mine_amount(mine_amount)
	
	queue_free()

