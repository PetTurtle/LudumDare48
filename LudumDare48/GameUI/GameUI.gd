extends Control

var buttons: Dictionary

onready var hotbar: Control = $Hotbar
onready var button_packed_scene = preload("res://GameUI/BehaviourButton.tscn")
onready var money_label: = $Label

onready var mine_image = preload("res://GameUI/Sprites/pick.png")
onready var shovel_image = preload("res://GameUI/Sprites/shovel.png")
onready var barrier_image = preload("res://GameUI/Sprites/barrier.png")
onready var jump_image = preload("res://GameUI/Sprites/jump.png")
onready var float_image = preload("res://GameUI/Sprites/balloon.png")
onready var explode_image = preload("res://GameUI/Sprites/explosion.png")

onready var mine_scene = preload("res://BehaviourZones/MineZone.tscn")
onready var shovel_scene = preload("res://BehaviourZones/DigZone.tscn")
onready var barrier_scene = preload("res://BehaviourZones/TurnAroundZone.tscn")
onready var jump_scene = preload("res://BehaviourZones/JumpZone.tscn")
onready var float_scene = preload("res://BehaviourZones/BalloonZone.tscn")
onready var explode_scene = preload("res://BehaviourZones/ExplodeZone.tscn")

func _ready():
	buttons = {
		"barrier": _create_button(barrier_image, 1, barrier_scene, false, -1, -1, true),
		"mine": _create_button(mine_image, 2, mine_scene, true, Vector2.AXIS_X, 5, false),
		"dig": _create_button(shovel_image, 2, shovel_scene, true, Vector2.AXIS_Y, 5, false),
		"jump": _create_button(jump_image, 3, jump_scene, false, -1, -1, true),
		"float": _create_button(float_image, 3, float_scene, false, -1, -1, false),
		"explode": _create_button(explode_image, 4, explode_scene, false, -1, -1, true)
	}
	
	G.connect("money_changed", self, "_on_money_change")


func _create_button(texture: StreamTexture, price: int, packed_scene: PackedScene, drag: bool, axis: int, max_distance: int, needs_floor: bool) -> TextureButton:
	var button: TextureButton = button_packed_scene.instance()
	hotbar.add_child(button)
	button.set_behaviour(texture, price, packed_scene, drag, axis, max_distance, needs_floor)
	return button

func _on_money_change():
	money_label.text = str(G.money)
