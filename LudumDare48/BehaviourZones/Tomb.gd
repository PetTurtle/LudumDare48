extends RigidBody2D

onready var audio: AudioStreamPlayer = $AudioStreamPlayer


func _ready():
	audio.ran_pitch()
	audio.play()
