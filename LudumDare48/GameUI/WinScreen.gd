extends Control

onready var time: Label = $HBoxContainer/HBoxContainer/Time
onready var deaths: Label = $HBoxContainer/HBoxContainer3/Deaths2
onready var coins: Label = $HBoxContainer/HBoxContainer2/TotalCoins2


func _ready():
	G.connect("game_over", self, "_on_game_over")


func _on_game_over():
	visible = true
	G.stop_timer()
	time.text = str(G.time)
	deaths.text = str(G.deaths)
	coins.text = str(G.total_money)
