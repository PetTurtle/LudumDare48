extends RigidBody2D

var curr_behaviour: Behaviour

onready var _sprite: AnimatedSprite = $Sprite
onready var _up_ray: RayCast2D = $UpRaycast
onready var _down_ray: RayCast2D = $DownRaycast
onready var _left_ray: RayCast2D = $LeftRaycast
onready var _right_ray: RayCast2D = $RightRaycast
onready var _walk_behaviour = preload("res://Behaviours/WalkBehaviour.tscn")


func _ready() -> void:
	set_behaviour(_walk_behaviour)


func _physics_process(_delta) -> void:
	_sprite.flip_h = linear_velocity.x < 0


func set_behaviour(behavour_packed_scene: PackedScene) -> void:
	if curr_behaviour != null:
		curr_behaviour.queue_free()
	
	curr_behaviour = behavour_packed_scene.instance()
	add_child(curr_behaviour)


func finish_behaviour() -> void:
	set_behaviour(_walk_behaviour)


func set_animation(animation: String) -> void:
	_sprite.animation = animation


func is_colliding(dir: Vector2) -> bool:
	if dir == Vector2.UP:
		return _up_ray.is_colliding()
	elif dir == Vector2.DOWN:
		return _down_ray.is_colliding()
	elif dir == Vector2.LEFT:
		return _left_ray.is_colliding()
	elif dir == Vector2.RIGHT:
		return _right_ray.is_colliding()
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
