extends Area2D

onready var walk_behaviour: PackedScene = load("res://Behaviours/WalkBehaviour.tscn")


func _on_Node2D_body_entered(body) -> void:
	if not visible:
		return
	
	var dwarf: PhysicsBody2D = body
	
	if dwarf.position.x < position.x:
		var walk = dwarf.set_behaviour(walk_behaviour)
		walk.set_moving_right(false)
	else:
		var walk = dwarf.set_behaviour(walk_behaviour)
		walk.set_moving_right(true)


func _input(_event):
	if Input.is_action_just_pressed("place_start") and position.distance_to(get_global_mouse_position()) < 3:
		self.visible = not self.visible
