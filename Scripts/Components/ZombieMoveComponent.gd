class_name CompZombieMove
extends Node

@export var body : StaticBody2D
@export var sprite : AnimatedSprite2D
@export var speed : float = 25
var undead : bool = true
var moving_left : bool = true
var attacking : bool = false

func _physics_process(delta: float) -> void:
	if undead && !attacking:
		body.position.x -= speed * delta
		body.move_and_collide(Vector2(0, 1))

func set_walking_direction() -> void:
	var screen = get_tree().root.get_viewport().size
	var middle_point = screen.x / 2
	if body.position.x < middle_point:
		sprite.flip_h = true
		moving_left = false
