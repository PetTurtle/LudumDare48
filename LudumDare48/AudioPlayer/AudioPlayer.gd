extends AudioStreamPlayer

export var max_pitch: float = 1.2
export var min_pitch: float = 0.8

func ran_pitch() -> void:
	pitch_scale = rand_range(min_pitch, max_pitch)
