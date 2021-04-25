extends Node

signal money_changed
signal money_increased

var time: int = 0
var timer: Timer
var total_money: int = 0
var money: int = 0
var deaths: int = 0
var dwarf_speed := 15

var flag: Node2D = null
var ui: Control
var map: Node2D
var dwarfs: Node2D
var behaviours: Node2D
var behaviour_placer: Node2D

onready var dwarf_scene: PackedScene = preload("res://Dwarf/Dwarf.tscn")

func _ready():
	timer = Timer.new()
	add_child(timer)
	timer.connect("timeout", self, "_time")
	

func start_timer():
	timer.start()

func stop_timer():
	timer.stop()

func _time():
	time += 1

func set_flag(node: Node2D) -> void:
	if flag == null:
		flag = node
	elif flag.position.y < node.position.y:
		flag = node


func set_ui(ui_control: Control) -> void:
	ui = ui_control


func set_map(map_node: Node2D) -> void:
	map = map_node


func set_dwarfs(dwarfs_node: Node2D) -> void:
	dwarfs = dwarfs_node


func set_behaviours(behaviours_node: Node2D) -> void:
	behaviours = behaviours_node


func set_behaviour_placer(behaviour_placer_node: Node2D) -> void:
	behaviour_placer = behaviour_placer_node


func set_money(value: int) -> void:
	if (money < value):
		emit_signal("money_increased")
		total_money += (money - value)
	
	money = value
	emit_signal("money_changed")


func spawn_dwarf() -> void:
	var dwarf = dwarf_scene.instance()
	dwarfs.add_child(dwarf)
	dwarf.position = flag.position
