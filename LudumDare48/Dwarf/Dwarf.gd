extends RigidBody2D

var max_velocity := 8

var curr_behaviour: Behaviour

onready var _sprite: AnimatedSprite = $Sprite
onready var _up_ray: RayCast2D = $UpRaycast
onready var _up_ray2: RayCast2D = $UpRaycast2
onready var _down_ray: RayCast2D = $DownRaycast
onready var _down_ray2: RayCast2D = $DownRaycast2
onready var _left_ray: RayCast2D = $LeftRaycast
onready var _left_ray2: RayCast2D = $LeftRaycast2
onready var _right_ray: RayCast2D = $RightRaycast
onready var _right_ray2: RayCast2D = $RightRaycast2
onready var _walk_behaviour: PackedScene = preload("res://Behaviours/WalkBehaviour.tscn")


func _ready() -> void:
	var _walk = set_behaviour(_walk_behaviour)


func _physics_process(_delta) -> void:
	if linear_velocity.x != 0:
		_sprite.flip_h = linear_velocity.x < 0
	


func set_behaviour(behavour_packed_scene: PackedScene) -> Node2D:
	if curr_behaviour != null:
		curr_behaviour.queue_free()
	
	curr_behaviour = behavour_packed_scene.instance()
	add_child(curr_behaviour)
	return curr_behaviour


func finish_behaviour() -> void:
	var _walk = set_behaviour(_walk_behaviour)


func set_animation(animation: String) -> void:
	_sprite.animation = animation


func is_colliding(dir: Vector2) -> bool:
	if dir == Vector2.UP:
		return _up_ray.is_colliding() or _up_ray2.is_colliding()
	elif dir == Vector2.DOWN:
		return _down_ray.is_colliding() or _down_ray.is_colliding()
	elif dir == Vector2.LEFT:
		return _left_ray.is_colliding() or _left_ray.is_colliding()
	elif dir == Vector2.RIGHT:
		return _right_ray.is_colliding() or _right_ray.is_colliding()
	return false


func get_collider(dir: Vector2) -> Object:
	if dir == Vector2.UP:
		return _up_ray.get_collider()
	elif dir == Vector2.DOWN:
		return _down_ray.get_collider()
	elif dir == Vector2.LEFT:
		return _left_ray.get_collider()
	elif dir == Vector2.RIGHT:
		return _right_ray.get_collider()
	return null
