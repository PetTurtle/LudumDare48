extends Node2D

var unlocked := false

export var unlock := ""

onready var parent: Area2D = get_parent()
onready var audio: AudioStreamPlayer = $AudioStreamPlayer


func _ready() -> void:
	var _e = parent.connect("body_entered", self, "_on_body_entered")


func _on_body_entered(_body: Node) -> void:
	if not unlocked:
		G.ui.unlock(unlock)
		audio.ran_pitch()
		audio.play()
		unlocked = true
