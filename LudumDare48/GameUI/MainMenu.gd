extends Control

var game_started := false

onready var start_button: Button = $Center/VBoxContainer/StartButton
onready var resume_button: Button = $Center/VBoxContainer/ResumeButton


func _on_StartButton_pressed():
	game_started = true
	self.visible = false
	start_button.visible = false
	resume_button.visible = true


func _on_ExitButton_pressed():
	get_tree().quit()
	


func _on_BackButton_pressed():
	self.visible = not self.visible


func _process(_delta):
	if game_started and Input.is_action_just_pressed("escape"):
		self.visible = not self.visible


func _on_MainMenu_visibility_changed():
		if visible:
			G.stop_timer()
			get_tree().paused = true
		else:
			G.start_timer()
			get_tree().paused = false
