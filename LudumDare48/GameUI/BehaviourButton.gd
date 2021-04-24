extends TextureButton

var packed_scene: PackedScene
var drag: bool
var axis: int
var max_distance: int

onready var price_label: Label = $PriceLabel
onready var behaviour_image: TextureRect = $BahaviourImage


func set_behaviour(texture: StreamTexture, price: int, _packed_scene: PackedScene, _drag: bool, _axis: int, _max_distance: int):
	behaviour_image.texture = texture
	price_label.text = str(price)
	packed_scene = _packed_scene
	drag = _drag
	axis = _axis
	max_distance = _max_distance


func _on_BehaviourButton_pressed():
	G.behaviour_placer.place(packed_scene, drag, axis, max_distance)
