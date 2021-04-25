extends Node2D


export var unlock := ""

onready var parent: Area2D = get_parent()


func _ready() -> void:
	var _e = parent.connect("body_entered", self, "_on_body_entered")


func _on_body_entered(_body: Node) -> void:
	G.ui.unlock(unlock)
