extends TextureButton

var stopped := false
onready var music: AudioStreamPlayer = $AudioStreamPlayer


func _on_MusicButton_pressed():
	if (music.playing):
		music.stop()
		stopped = true
	else:
		music.play()
		stopped = false


func _on_AudioStreamPlayer_finished():
	if not stopped:
		music.play()
