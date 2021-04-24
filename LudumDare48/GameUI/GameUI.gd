extends Control

var buttons: Dictionary

onready var hotbar: Control = $Hotbar
onready var button_packed_scene = preload("res://GameUI/BehaviourButton.tscn")

onready var mine_image = preload("res://GameUI/Sprites/pick.png")
onready var shovel_image = preload("res://BehaviourZones/Sprites/mine.png")
onready var barrier_image = preload("res://GameUI/Sprites/barrier.png")
onready var jump_image = preload("res://BehaviourZones/Sprites/mine.png")
onready var float_image = preload("res://BehaviourZones/Sprites/mine.png")
onready var explode_image = preload("res://BehaviourZones/Sprites/mine.png")

onready var mine_scene = preload("res://BehaviourZones/MineZone.tscn")
onready var shovel_scene = preload("res://BehaviourZones/MineZone.tscn")
onready var barrier_scene = preload("res://BehaviourZones/TurnAroundZone.tscn")
onready var jump_scene = preload("res://BehaviourZones/MineZone.tscn")
onready var float_scene = preload("res://BehaviourZones/MineZone.tscn")
onready var explode_scene = preload("res://BehaviourZones/MineZone.tscn")

func _ready():
	buttons = {
		"mine": _create_button(mine_image, 1, mine_scene, true, Vector2.AXIS_X, 5),
		"shovel": _create_button(shovel_image, 1, shovel_scene, true, Vector2.AXIS_Y, 5),
		"barrier": _create_button(barrier_image, 1, barrier_scene, false, -1, -1),
		"jump": _create_button(jump_image, 1, jump_scene, false, -1, -1),
		"float": _create_button(float_image, 1, float_scene, false, -1, -1),
		"explode": _create_button(explode_image, 1, explode_scene, false, -1, -1)
	}


func _create_button(texture: StreamTexture, price: int, packed_scene: PackedScene, drag: bool, axis: int, max_distance: int) -> TextureButton:
	var button: TextureButton = button_packed_scene.instance()
	hotbar.add_child(button)
	button.set_behaviour(texture, price, packed_scene, drag, axis, max_distance)
	return button
