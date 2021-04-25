extends Control

onready var time: Label = $HBoxContainer/HBoxContainer/Time
onready var deaths: Label = $HBoxContainer/HBoxContainer3/Deaths2
onready var coins: Label = $HBoxContainer/HBoxContainer2/TotalCoins2


func _on_WinScreen_visibility_changed():
	G.stop_timer()
	time.text = str(G.time)
