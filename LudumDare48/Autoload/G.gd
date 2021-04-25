extends Node

var money = 0
var dwarf_speed := 15

var map: Node2D
var dwarfs: Node2D
var behaviours: Node2D
var behaviour_placer: Node2D


func set_map(map_node: Node2D) -> void:
	map = map_node


func set_dwarfs(dwarfs_node: Node2D) -> void:
	dwarfs = dwarfs_node


func set_behaviours(behaviours_node: Node2D) -> void:
	behaviours = behaviours_node


func set_behaviour_placer(behaviour_placer_node: Node2D) -> void:
	behaviour_placer = behaviour_placer_node
